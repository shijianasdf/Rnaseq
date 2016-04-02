####################################################################################################
# Given a set of known CNV and a set of annotated genomic regions, such as exons and promoter, 
# calculate the copy number each of the genomic region has based on its overlapping to the CNVs.
CalculateCopy<-function(cnv, region, copy=elementMetadata(cnv)[, 1], keep.all=TRUE) {
  # cnv       GRanges object, the genomic location of CNVs
  # region    GRanges object, the genomic regions to be mapped to CNV sites
  # copy      The copy number of each CNV site, must match length
  # keep.all  Whether to keep regions not overlapped to the CNVs in the output; if TRUE, copy number of all non-overlapping sites will be 2.0
  
  library(GenomicRanges);
  
  ct0<-countOverlaps(cnv, cnv); 
  if (any(ct0>1)) warning("There are overlapping CNVs.\n", 
                          "Check CNV transitional sites to make sure CNVs are mutually exclusive of each other\n");
  
  # number of overlapped CNVs
  ct<-countOverlaps(region, cnv); 
  
  # Copy number
  cp<-rep(2, length(region)); 
  
  cov<-coverage(cnv, weight=copy); 
saveRDS(cov, 'test1.rds'); 
  if (any(ct>0)) {
    dep<-cov[region[ct>0]]; 
 saveRDS(dep, 'test2.rds');    
    d<-split(dep, rep(1:ceiling(length(dep)/10000), each=10000)[1:length(dep)]); 
    if (length(d)==1) m<-sapply(dep, mean) else {
      m<-parallel::mclapply(d, mean, mc.cores=min(8, length(d))); 
      saveRDS(m, 'test3.rds');
      m<-unlist(lapply(m, as.vector), use.names=FALSE); 
      saveRDS(m, 'test4.rds');
    }
    cp[ct>0]<-m;
  }
  
  region$cnv_copy<-cp;
  region$cnv_site<-ct;
  
  if (!keep.all) region<-region[ct>0]; 
  
  region; 
}

####################################################################################################
# Calculate transcript level copy number based on exon level copy number, as well as exon-transcript mapping
CalculateCopyTx<-function(exon, tx, cn) {
  # exon    GRanges object of all exon locations
  # tx      Transcript IDs, must match length and order of exons
  # cn      Exon-level copy number, must match length and order of exons
  
  if (length(exon) != length(tx)) stop('Error: number of exons does not match length of transcript IDs\n'); 
  if (length(exon) != length(cn)) stop('Error: number of exons does not match length of copy number values\n'); 
  
  wid<-split(width(exon), tx); 
  cpy<-split(cn, tx); 

  n<-sapply(wid, length); 
  l<-sapply(wid, sum); 
  c<-sapply(1:length(wid), function(i) weighted.mean(cpy[[i]], wid[[i]])); 
  
  cbind(exon=n, length=l, copy=c); 
}