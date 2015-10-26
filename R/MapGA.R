LoadGa<-function(bam, gr=NA, paired=TRUE, exons=NA, ex2tx=c(), tx2gn=c(), min.mapq=1, strand.match=0) {
  # bam             Full path to bam file
  # gr              GRanges object specifies regions or chromsomes; the whole bam file if NA
  # paired          Paired or single ended reads
  # exons           Location of exons
  # ex2tx           Exon to transcript mapping
  # tx2gn           Transcript to gene mapping
  # strand.match    Read-to-exon strand match; 0 no match; 1 match; -1 reverse match. Should be reverse match for most RNA-seq protocols  
  
  require("GenomicRanges");
  require("GenomicAlignments");
  require("Rnaseq");

  if (identical(gr, NA)) {
    chr<-scanBamHeader(bam)[[1]][[1]];
    gr<-GRanges(names(chr), IRanges(1, chr));
  } 

  gr<-lapply(unique(as.vector(seqnames(gr))), function(c) gr[seqnames(gr)==c]);
  names(gr)<-sapply(gr, function(gr) as.vector(seqnames(gr))[1]);

  #ncore<-min(max.cluster, length(gr));
  
  # Loading reads
  reads<-lapply(gr, function(g) {
    cat("Loading reads on chromosome", as.vector(seqnames(g))[1], '\n');
    if (paired) LoadGaPe(bam, g, min.mapq) else LoadGaSe(bam, gr[[nm]], min.mapq);
  }); 
print(1);
  reads<-lapply(reads, function(rd) {
    if (length(rd[[1]])>0) {
      if (paired) {
        if (!identical(exons, NA)) {
          rd$interval[[1]]<-MapInterval2Exon(rd$interval[[1]], exons, 'within', strand.match, ex2tx, tx2gn); print(2);
          rd$interval[[2]]<-MapInterval2Exon(rd$interval[[2]], exons, 'within', -1*strand.match, ex2tx, tx2gn); print(3);
        } 
      } else {
        if (!identical(exons, NA)) {
          rd$interval<-MapInterval2Exon(rd$interval, exons, 'within', strand.match, ex2tx, tx2gn);
        }
      }
    } print(4);
    rd$dumped<-MapInterval2Exon(ConvertGa2Gr(rd$dumped), exons, 'within', 0, ex2tx, tx2gn); print(5);
    
    rd; 
  });
  names(reads)<-names(gr);

  reads;
}

# Maping mapped read intervals to exons or other ungapped genomic features
MapInterval2Exon<-function(intv, exons, type='within', strand=0, ex2tx=c(), tx2gn=c()) {
  # intv    GRanges object, genomic intervals returned by the ConvertGa2Gr function
  # exons   GRanges object, location of exons or other ungapped genomic features; must have unique names
  # type    Type of overlapping, by default, mapping interval must be completely within exon
  # strand  Whether the overlapping should match strand; 0 no matrch, 1 must match, -1 must match reversely

  require("GenomicRanges");
  require("GenomicAlignments");
  
  if (strand == 0) ig<-TRUE else ig<-FALSE;
  
  if (strand < 0) strand(exons)<-c('+'='-', '-'='+', '*'='*')[as.vector(strand(exons))];
  
  olap<-as.matrix(findOverlaps(intv, exons, type=type, ignore.strand=ig));
  
  mp<-intv[olap[, 1]];
  ex<-exons[olap[, 2]];
  mp$exon<-names(ex);
  
  mx<-rep(0, length(mp)); # max extension allowed by the boundary of exon
  ext<-mp$extension;
  str0<-as.vector(strand(mp));
  stt0<-start(mp);
  end0<-end(mp);
  str1<-as.vector(strand(ex));
  stt1<-start(ex);
  end1<-end(ex);
  ind<-which(str0=='-' & ext>0);
  if (length(ind)>0) mx[ind] <- pmin(stt0[ind]-stt1[ind], ext[ind]);
  ind<-which(str0=='+' & ext>0);
  if (length(ind)>0) mx[ind] <- pmin(end1[ind]-end0[ind], ext[ind]);
  mp$same.strand<-str0==str1;
  if (strand==-1) mp$same.strand<-!mp$same.strand;
  mp$max.extension<-mx;
  
  if (length(ex2tx)) mp$transcript<-as.vector(ex2tx[mp$exon]);
  if (length(tx2gn)) mp$gene<-as.vector(tx2gn[mp$transcript]);
  
  mp;
}

# Load BAM file of paired end reads
LoadGaPe<-function(bam, gr, min.mapq=1, wht=character(0)) {
  
  require("GenomicRanges");
  require("GenomicAlignments");

  prm<-ScanBamParam(which=gr, what=wht, mapqFilter=min.mapq, flag=scanBamFlag(
    isPaired=TRUE,
    isUnmappedQuery=FALSE,
    hasUnmappedMate=FALSE,
    isNotPassingQualityControls=FALSE)); 

  flushDumpedAlignments();
  reads<-readGAlignmentPairs(bam, use.names=TRUE, param=prm);
  dmp<-getDumpedAlignments();
  
  gr.fst<-ConvertGa2Gr(reads@first);
  gr.lst<-ConvertGa2Gr(reads@last);
  
  loaded<-list(names=reads@NAMES, paired=TRUE, interval=list(first=gr.fst, last=gr.lst), dumped=dmp);

  loaded;
}

# Load BAM file of single end reads
LoadGaSe<-function(bam, gr, min.mapq=1, wht=character(0)) {
  
  require("GenomicRanges");
  require("GenomicAlignments");
  
  prm<-ScanBamParam(which=gr, what=wht, mapqFilter=min.mapq, flag=scanBamFlag(
    isUnmappedQuery=FALSE,
    isNotPassingQualityControls=FALSE));
  
  flushDumpedAlignments();
  reads<-readGAlignments(bam, use.names=TRUE, param=prm);
  dmp<-getDumpedAlignments();
  
  gr<-ConvertGa2Gr(reads@first);
  
  loaded<-list(names=reads@NAMES, paired=FALSE, interval=gr, dumped=dmp);
  
  loaded;
}

# Convert gapped alignment of reads to split intervals without gap
ConvertGa2Gr<-function(ga, read.length=max(qwidth(ga)), use.names=FALSE) {
  # ga            A <GAlignment> object
  # read.length   Sequencing read length
  # use.names     Use original read ID to label intervals
  
  gr.list<-grglist(ga); 
  n<-elementLengths(gr.list);print(class(gr.list[[1]]));

  gr<-BiocGenerics::unlist(gr.list); 
  gr$read<-rep(1:length(ga), n);

  # The interval that is the first or the last interval of a read (strand specific);
  cumsum(n)->rsum;
  end<-rsum;
  stt<-c(1, rsum[-length(rsum)]+1);
  str<-as.vector(strand(ga));
  
  fst<-rep(0, length(gr)); 
  fst[stt[str=='+']]<-1;
  fst[end[str=='-']]<-1;
  gr$is.first<-fst;
  
  lst<-rep(0, length(gr));
  lst[end[str=='+']]<-1;
  lst[stt[str=='-']]<-1;
  gr$is.last=lst;
  
  # Possible extension of the last interval when the total mapped length is smaller than read length
  w<-width(gr); 
  w<-split(w, gr$read);
  len<-sapply(w, sum);  # total mapped length of a read (reads with deletion will be longer than read length);
  ex<-pmax(0, read.length-len);
  ext<-rep(0, length(gr));
  ext[lst==1]<-ex;
  gr$extension<-ext;
  
  if (use.names & !is.null(names(ga))) gr$read<-names(ga)[gr$read];
  
  gr;
}
