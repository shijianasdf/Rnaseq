# Normalize a read count matrix from RNA-seq
NormalizeRNAseq <- function(cnt, len=NA, methods=c("NormTotalCount", "NormMedian", "NormQQ", "NormUpperQuantile", "NormRLE", 
                                                   "NormTMM", "NormDESeq", "NormLoess", "NormFPKM", "NormTPM")) {
  
  norm <- list(Original=cnt); 
  
  if ("NormTotalCount" %in% methods) norm$Total_Count <- round(NormTotalCount(cnt)); 
  if ("NormMedian" %in% methods) norm$Median <- round(NormMedian(cnt)); 
  if ("NormQQ" %in% methods) norm$Quantile_Quantile <- round(NormMedian(cnt, ref='median')); 
  if ("NormUpperQuantile" %in% methods) norm$Upper_Quantile <- round(NormUpperQuantile(cnt)); 
  if ("NormTMM" %in% methods) norm$Trimmed_Mean <- round(NormTMM(cnt)); 
  if ("NormDESeq" %in% methods) norm$DESeq <- round(NormDESeq(cnt)); 
  if ("NormFPKM" %in% methods & length(len)==nrow(cnt)) norm$FPKM <- NormFPKM(cnt, len); 
  if ("NormTPM" %in% methods & length(len)==nrow(cnt)) norm$TPM <- NormTPM(cnt, len); 
  if ("NormLoess" %in% methods) {
    d <- log(cnt+1); 
    d <- exp(NormLoess(d))-1; 
    d[d<0] <- 0;
    norm$Loess <- round(d);
  }
  
  norm; 
}