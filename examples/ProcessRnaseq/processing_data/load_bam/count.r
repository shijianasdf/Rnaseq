require("Rnaseq");
require("GenomicRanges");

exon <- readRDS("/mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/hg38_exon.rds");
anno <- MapExon2Gene(exon, "transcript_id", "gene_id"); 
saveRDS(anno, "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/exon2gene.rds");
saveRDS(anno$gene[, -(4:5)], "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/anno.rds");

ct <- Rnaseq::CombineCounts(readRDS('/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/file_count.rds'));
saveRDS(ct, "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/count_all.rds");
saveRDS(ct[[1]], "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/count_gene.rds");
c <- ct[[1]]; c <- log2(1+c[rowSums(c) > 0, , drop=FALSE]); 
saveRDS(DEGandMore::NormLoess(c), "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/normalized.rds");
sapply(names(ct), function(nm) saveRDS(ct[[nm]], paste("/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam", "/count_", nm, ".rds", sep=""))) -> x;
