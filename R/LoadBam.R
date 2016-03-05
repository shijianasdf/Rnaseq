# This is a function to load a BAM files and maps reads to known genes
# It uses specifications given in a yaml file
# Loaded reads will be mapped to genes
LoadBam<-function(fn.yaml) {
  
  
  # read in the .yml file
  # fn.yaml<-'LoadBam.yml';
  yml<-yaml::yaml.load_file(fn.yaml);
  
  require("GenomicRanges");
  require("GenomicAlignments");
  require("Rnaseq");
  
  bam<-yml$bam;
  paired<-yml$paired;
  min.mapq<-yml$mapq;
  strand.match<-yml$strand;
  wht<-yml$what;
  
  path<-paste(yml$output, yml$name, sep='/');
  if (!file.exists(path)) dir.create(path, recursive = TRUE); 
  
  if (is.null(yml$region)) gr<-NA else {
    gr<-GRanges(names(yml$region), IRanges(as.vector(sapply(yml$region, min)), as.vector(sapply(yml$region, max))));
  }
  
  # Exon annotation and location
  exons<-readRDS(yml$exon);
  cnm<-colnames(elementMetadata(exons));
  
  # Exon to transcript mapping
  if ("transcript_id" %in% cnm) {
    ex2tx<-as.vector(exons$transcript_id);
    names(ex2tx)<-names(exons);
  } else ex2tx<-NA;
  
  # Exon to gene mapping
  if ("gene_id" %in% cnm & "transcript_id" %in% cnm) {
    tx2gn<-as.vector(exons$gene_id);
    names(tx2gn)<-as.vector(exons$transcript_id);
    tx2gn<-tx2gn[!duplicated(names(tx2gn))];
  } else tx2gn<-NA;
  
  # Loading/writing
  if (!yml$split$split) {
    ga<-LoadGa(bam, gr, TRUE, exons, ex2tx, tx2gn, min.mapq, strand.match);
    saveRDS(ga, paste(path, 'loaded.rds', sep='/'));
    ct<-CountRead(ga, feature = yml$feature, ncl = yml$thread, match.strand = strand.match);
    saveRDS(ct, paste(path, 'count.rds', sep='/'));
  } else { # Split reads when BAM is too big or other reasons
    # Individual chromosomes
    chr<-seqlevels(gr);
    chr<-chr[chr %in% as.vector(seqnames(gr))]; 
    
    # Load reads by chromosome and by read subgroups
    path.group<-lapply(chr, function(c) { # Load a chromosome
      g<-gr[as.vector(seqnames(gr))==c];
      ga<-LoadGa(bam, g, TRUE, exons, ex2tx, tx2gn, min.mapq, strand.match)[[1]];
      saveRDS(ga, paste(path, paste(c, '_loaded.rds', sep=''), sep='/'));
      ga.list<-SplitGa(ga, sep=yml$split$separator, level=yml$split$level); 
      path.group<-sapply(names(ga.list), function(nm) {cat(nm, '\n'); 
        p<-paste(path, nm, sep='/');
        if (!file.exists(p)) dir.create(p, recursive = TRUE); 
        saveRDS(ga.list[[nm]], paste(p, paste(c, '_loaded.rds', sep=''), sep='/'));
        p;
      }); 
      path.group;
    }); 
    path.group<-sort(unique(unlist(path.group, use.names=FALSE))); 
    
    # Read count by read subgroups
    ct.all<-lapply(path.group, function(pth) {
      f<-dir(pth);
      f<-f[grep('_loaded.rds$', f)]; 
      fn<-paste(pth, f, sep='/'); 
      ga.list<-lapply(fn, readRDS); 
      names(ga.list)<-sub('_loaded.rds$', '', f); 
      ct<-CountRead(ga.list, feature = yml$feature, ncl = yml$thread, match.strand = strand.match)[[1]][[1]];
      saveRDS(ct, paste(pth, 'count.rds', sep='/')); 
      ct;
    });
    
    gid<-lapply(ct.all, rownames); 
    gid<-sort(unique(unlist(gid, use.names=FALSE)));
    ct<-matrix(0, nr=length(gid), nc=ncol(ct.all[[1]]), dimnames=list(gid, colnames(ct.all[[1]])));
    ct.all<-lapply(ct.all, function(c) {
      ct[rownames(c), ]<-c; 
      ct;
    });
    ct<-Reduce('+', ct.all);
    saveRDS(ct, paste(path, 'count.rds', sep='/'));
  }

  ct;
}