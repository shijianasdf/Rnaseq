## ND422-T
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");

fn.yaml <- ("/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/ND422-T/LoadBam.yml");
ct<-LoadBam(fn.yaml);

saveRDS(ct[[1]][[1]], /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/load_bam/ND422-T/just_count.rds
