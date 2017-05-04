# Load gapped aligned reads from BAM files
# Optionally, annotate reads with exon, transcript and gene
LoadGa<-function(bam, gr=NA, paired=TRUE, exons=NA, ex2tx=c(), tx2gn=c(), min.mapq=1, strand.match=0, wht=character(0)) {
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
  
  tx2gn<-tx2gn[!is.na(tx2gn)];
  tx2gn<-tx2gn[!is.na(names(tx2gn))]; 
  ex2tx<-ex2tx[!is.na(ex2tx)];

  gr<-lapply(unique(as.vector(gr@seqnames@values)), function(c) gr[seqnames(gr)==c]);
  names(gr)<-sapply(gr, function(gr) as.vector(gr@seqnames@values)[1]);
  gr<-gr[names(gr) %in% names(scanBamHeader(bam)[[1]][[1]])];
  if (length(gr) == 0) stop("Error: no given chromosome names were found in bam file")


  # Loading reads
  reads<-lapply(gr, function(g) {
    cat("Loading reads on chromosome", as.vector(g@seqnames@values)[1], '\n');
    if (paired) LoadGaPe(bam, g, min.mapq, wht) else LoadGaSe(bam, gr[[nm]], min.mapq, wht);
  }); 
  
  N<-sapply(reads, function(x) length(x[[1]])); 
  cat("Loaded a total of", sum(N), 'reads mapped to', length(reads), 'chromosomes\n');

  reads<-lapply(reads, function(rd) {
    if (length(rd[[1]])>0) {
      if (paired) {
        if (!identical(exons, NA)) {
          cat("Mapping", length(rd[[3]][[1]]), "reads to sense strand of exons\n")
          if (length(rd$interval[[1]])>0) rd$interval[[1]]<-MapInterval2Exon(rd$interval[[1]], exons, 'within', strand.match, ex2tx, tx2gn); 
          cat("Mapping", length(rd[[3]][[2]]), "reads to antisense strand of exons\n")
          if (length(rd$interval[[2]])>0) rd$interval[[2]]<-MapInterval2Exon(rd$interval[[2]], exons, 'within', -1*strand.match, ex2tx, tx2gn); 
        } 
      } else {
        if (!identical(exons, NA)) {
          rd$interval<-MapInterval2Exon(rd$interval, exons, 'within', strand.match, ex2tx, tx2gn);
        }
      }
    }; 
    if (is.null(rd$dumped)) rd$dumped<-NULL else
      rd$dumped<-MapInterval2Exon(ConvertGa2Gr(rd$dumped), exons, 'within', 0, ex2tx, tx2gn); 
    
    rd; 
  });
  names(reads)<-names(gr);

  reads;
}

# Maping mapped read intervals to exons or other ungapped genomic features
MapInterval2Exon<-function(intv, exons, type='within', strand=0, ex2tx=c(), tx2gn=c(), keep=TRUE) {
  # intv    GRanges object, genomic intervals returned by the ConvertGa2Gr function
  # exons   GRanges object, location of exons or other ungapped genomic features; must have unique names
  # type    Type of overlapping, by default, mapping interval must be completely within exon
  # strand  Whether the overlapping should match strand; 0 no matrch, 1 must match, -1 must match reversely
  # keep    Keep un-mapped intervals if TRUE
  
  require("GenomicRanges");
  require("GenomicAlignments");
  
  if (strand == 0) ig<-TRUE else ig<-FALSE;
  
  if (strand < 0) strand(exons)<-c('+'='-', '-'='+', '*'='*')[as.vector(strand(exons))];
  x<-findOverlaps(intv, exons, type=type, ignore.strand=ig);
  olap<-cbind(x@queryHits, x@subjectHits);

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
  
  if (keep) {
    unm<-intv[setdiff(1:length(intv), x@queryHits)];
    unm$exon<-rep('', length(unm));
    unm$same.strand<-rep(FALSE, length(unm));
    unm$max.extension<-rep(0, length(unm));
    unm$transcript<-rep('', length(unm));
    unm$gene<-rep('', length(unm));
    mp<-c(mp, unm);
    mp<-mp[order(mp$read)];
  }
  
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

  cat("Loading gapped alignment pairs from", bam, '\n');
  flushDumpedAlignments();
  reads<-readGAlignmentPairs(bam, use.names=TRUE, param=prm);
  
  dmp <- NA; 
  try(dmp <- getDumpedAlignments());
  
  cat("Converting loaded reads to GRanges object\n");
  if (length(reads@first) > 0) gr.fst<-ConvertGa2Gr(reads@first) else gr.fst<-NULL;
  if (length(reads@last)  > 0) gr.lst<-ConvertGa2Gr(reads@last ) else gr.lst<-NULL;
  
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
  
  dmp <- NULL;
  try(dmp <- getDumpedAlignments());
  
  gr<-ConvertGa2Gr(reads);
  
  loaded<-list(names=reads@NAMES, paired=FALSE, interval=gr, dumped=dmp);
  
  loaded;
}

# Convert gapped alignment of reads to split intervals without gap
ConvertGa2Gr<-function(ga, read.length=max(qwidth(ga)), use.names=FALSE) {
  # ga            A <GAlignment> object
  # read.length   Sequencing read length
  # use.names     Use original read ID to label intervals
  
  gr.list<-grglist(ga); 
  n<-elementLengths(gr.list);

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

# Split loaded gapped alignment into read groups based on read IDs
SplitGa<-function(ga, sep, level) {
  # ga    Gapped alginment as loaded by the LoadGa function
  # sep   Separator symbol in read id
  # level Levels in read id to group reads; For example, when sep=':' and level=3, 
  #       group ID of read "FCC7BBPACXX:1:1113:3906:59265#" is FCC7BBPACXX:1:1113 
 
  # Grouping reads
  id<-ga$names;
  ind<-sapply(gregexpr(sep, id), function(x) x[level]); 
  gp<-substr(id, 1, ind-1); 
  rd<-1:length(id);
  names(rd)<-id;
  grp<-split(rd, gp); 
  
  # Split reads
  intr<-lapply(ga$interval, function(x) {
    g<-gp[x$read];
    split(x, g);
  }); 
  
  ga.list<-lapply(names(grp), function(nm) {
    #cat(nm, '\n'); 
    ids<-grp[[nm]]; 
    ids.new<-1:length(ids);
    names(ids.new)<-ids;
    g<-list(names=names(ids), paired=ga$paired);
    it<-lapply(intr, function(x) x[[nm]]); 
    g$interval<-lapply(it, function(x) {
      x$read<-as.vector(ids.new[as.character(x$read)]);
      x;
    });
    g;
  });
  names(ga.list)<-names(grp);
  
  ga.list;
}
