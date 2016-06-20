## ND410-M
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");

fn.yaml <- ("/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/ND410-M/LoadBam.yml");
ct<-LoadBam(fn.yaml);

saveRDS(ct[[1]][[1]], /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/ND410-M/just_count.rds
