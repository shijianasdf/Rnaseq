## SLE1169-M
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");

fn.yaml <- ("/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/SLE1169-M/LoadBam.yml");
ct<-LoadBam(fn.yaml);

saveRDS(ct[[1]][[1]], /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/SLE1169-M/just_count.rds
