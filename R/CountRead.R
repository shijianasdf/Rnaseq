CountRead<-function(ga.list, feature=c('gene'), ncl=1, match.strand=0) {
  # ga.list     Gapped alignment of reads loaded by the Rnaseq::LoadGa function, split by chromosomes
  # feature     Genomic feature to make the read count, such as 'exon', 'gene'
  
  require("GenomicRanges");
  require("GenomicAlignments");
  require("Rnaseq");
  
  feature<-tolower(feature);
  
  if ('gene' %in% feature) CountGeneRead(ga.list, ncl);
}

GetUniqueMapping<-function(gr, read.name, feature, match.strand=0) {
  
  require("GenomicRanges");
  require("GenomicAlignments");
  require("Rnaseq");
  
  if (!feature %in% names(elementMetadata(gr))) matrix(nr=0, nc=2) else {
    df<-cbind(read.name[gr$read], as.vector(elementMetadata(gr)[, feature])); 
    
    if (match.strand<0) df<-df[!gr$same.strand, , drop=FALSE] else 
      if (match.strand>0) df<-df[gr$same.strand, , drop=FALSE]
    
    df<-df[!duplicated(df), , drop=FALSE];
    df;
  }
}

MapRead2Feature<-function(ga.list, feature, ncl=1, match.strand=0) {
  
  require("GenomicRanges");
  require("GenomicAlignments");
  require("Rnaseq");

  paired<-ga.list[[1]]$paired;
  
  ncl<-min(ncl, length(ga.list));
  
  if (paired) {
    mp.fst<-parallel::mclapply(ga.list, function(ga) GetUniqueMapping(ga[[3]][[1]], ga[[1]], feature, match.strand), mc.cores = ncl);
    mp.lst<-parallel::mclapply(ga.list, function(ga) GetUniqueMapping(ga[[3]][[2]], ga[[1]], feature, -1*match.strand), mc.cores = ncl);
    mp<-parallel::mclapply(list(mp.fst, mp.lst), function(lst) do.call('rbind', lst));
    mp<-parallel::mclapply(mp, function(mp) lapply(split(mp[, 1], mp[, 2]), unique));
  } else {
    mp<-parallel::mclapply(ga.list, function(ga) GetUniqueMapping(ga[[3]], ga[[1]], feature, match.strand), mc.cores = ncl);
    mp<-do.call('rbind', mp);
    mp<-lapply(split(mp[, 1], mp[, 2]), unique);
  }
  
  mp;
}

GetGeneCount<-function(ga.list, ncl=1, match.strand=0) {
  mapped.same<-MapRead2Feature(ga.list, 'gene', ncl, 1); 
  mapped.rev<-MapRead2Feature(ga.list, 'gene', ncl, -1); 
  
  paired<-ga.list[[1]]$paired;
  
  ##############################################################
  # Paired end reads
  if (paired) {
    ##############################################################
    # strand specific cDNA library
    if (match.strand !=0) { # strand-specific mapping
      if (match.strand > 0) { # cDNA library matching sense strand
        mapped<-MapRead2Feature(ga.list, 'gene', ncl, 1);  # mapped to sense strand
        mapped.anti<-MapRead2Feature(ga.list, 'gene', ncl, -1);  # mapped to antisense strand
      } else { # cDNA library matching anti-sense strand
        mapped<-MapRead2Feature(ga.list, 'gene', ncl, -1);  # mapped to sense strand
        mapped.anti<-MapRead2Feature(ga.list, 'gene', ncl, 1);  # mapped to antisense strand
      }
      
      
    } else { 
      ##############################################################
      # strand non-specific cDNA library  
      mapped.same<-MapRead2Feature(ga.list, 'gene', ncl, 1);  # mapped to sense strand
      mapped.rev<-MapRead2Feature(ga.list, 'gene', ncl, -1);  # mapped to antisense strand
      
    }
  }
}