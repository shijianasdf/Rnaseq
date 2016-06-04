# Normalize a read count matrix from RNA-seq
NormalizeRNAseq <- function(cnt, len=NA, methods=c("NormTotalCount", "NormMedian", "NormQQ", "NormUpperQuantile", "NormRLE", 
                                                   "NormTMM", "NormDESeq", "NormLoess", "NormFPKM", "NormTPM")) {
  
  norm <- list(Original=cnt); 
  
  if ("NormTotalCount" %in% methods) norm$Total_Count <- NormTotalCount(cnt); 
  if ("NormMedian" %in% methods) norm$Median <- NormMedian(cnt); 
  if ("NormQQ" %in% methods) norm$Quantile_Quantile <- NormMedian(cnt, ref='median'); 
  if ("NormUpperQuantile" %in% methods) norm$Upper_Quantile <- NormUpperQuantile(cnt); 
  if ("NormRLE" %in% methods) norm$edgeR_RLE <- NormRLE(cnt); 
  if ("NormTMM" %in% methods) norm$edgeR_TMM <- NormTMM(cnt); 
  if ("NormDESeq" %in% methods) norm$DESeq <- NormDESeq(cnt); 
  if ("NormFPKM" %in% methods & length(len)==nrow(cnt)) norm$FPKM <- NormFPKM(cnt, len); 
  if ("NormTPM" %in% methods & length(len)==nrow(cnt)) norm$TPM <- NormTPM(cnt, len); 
  if ("NormLoess" %in% methods) {
    d <- log(cnt+1); 
    d <- NormLoess(d); 
    d[d<0] <- 0; 
    norm$Loess <- d;
  }
  
  norm <- lapply(norm, round); 
  
  norm; 
}