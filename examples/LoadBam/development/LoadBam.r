#######################
## LPS2869
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");

fn.yaml<-'/mnt/isilon/cbmi/variome/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/LPS2869/LoadBam.yml';
ct<-LoadBam(fn.yaml); 

