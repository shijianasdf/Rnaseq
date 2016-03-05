#######################
## 2863C-L1F
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2863C-L1F_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2863C-L1F/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2863C-L1F/count.rds")


#######################
## 2863C-L1FL
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2863C-L1FL_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2863C-L1FL/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2863C-L1FL/count.rds")


#######################
## 2863C-L2F
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2863C-L2F_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2863C-L2F/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2863C-L2F/count.rds")


#######################
## 2863C-L2FL
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2863C-L2FL_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2863C-L2FL/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2863C-L2FL/count.rds")


#######################
## 2864C-L1M
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2864C-L1M_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L1M/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L1M/count.rds")


#######################
## 2864C-L1ML
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2864C-L1ML_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L1ML/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L1ML/count.rds")


#######################
## 2864C-L2M
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2864C-L2M_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L2M/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L2M/count.rds")


#######################
## 2864C-L2ML
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2864C-L2ML_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L2ML/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L2ML/count.rds")


#######################
## 2864C-L3F
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2864C-L3F_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L3F/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L3F/count.rds")


#######################
## 2864C-L3FL
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2864C-L3FL_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L3FL/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2864C-L3FL/count.rds")


#######################
## 2865C-L1F
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2865C-L1F_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2865C-L1F/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2865C-L1F/count.rds")


#######################
## 2865C-L1FL
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2865C-L1FL_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2865C-L1FL/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2865C-L1FL/count.rds")


#######################
## 2865C-L2M
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2865C-L2M_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2865C-L2M/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2865C-L2M/count.rds")


#######################
## 2865C-L2ML
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2865C-L2ML_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2865C-L2ML/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2865C-L2ML/count.rds")


#######################
## 2866C-L1M
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2866C-L1M_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2866C-L1M/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2866C-L1M/count.rds")


#######################
## 2866C-L1ML
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2866C-L1ML_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2866C-L1ML/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2866C-L1ML/count.rds")


#######################
## 2867LPS-L1M
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2867LPS-L1M_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-L1M/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-L1M/count.rds")


#######################
## 2867LPS-L1ML
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2867LPS-L1ML_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-L1ML/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-L1ML/count.rds")


#######################
## 2867LPS-L2M
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2867LPS-L2M_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-L2M/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-L2M/count.rds")


#######################
## 2867LPS-L2ML
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2867LPS-L2ML_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-L2ML/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-L2ML/count.rds")


#######################
## 2867LPS-R1F
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2867LPS-R1F_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-R1F/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-R1F/count.rds")


#######################
## 2867LPS-R1FL
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2867LPS-R1FL_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-R1FL/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2867LPS-R1FL/count.rds")


#######################
## 2868LPS-L2M
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2868LPS-L2M_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2868LPS-L2M/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2868LPS-L2M/count.rds")


#######################
## 2868LPS-L2ML
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2868LPS-L2ML_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2868LPS-L2ML/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2868LPS-L2ML/count.rds")


#######################
## 2868LPS-R1F
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2868LPS-R1F_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2868LPS-R1F/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2868LPS-R1F/count.rds")


#######################
## 2868LPS-R1FL
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2868LPS-R1FL_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2868LPS-R1FL/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2868LPS-R1FL/count.rds")


#######################
## 2870LPS-L1F
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2870LPS-L1F_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-L1F/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-L1F/count.rds")


#######################
## 2870LPS-L1FL
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2870LPS-L1FL_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-L1FL/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-L1FL/count.rds")


#######################
## 2870LPS-L2F
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2870LPS-L2F_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-L2F/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-L2F/count.rds")


#######################
## 2870LPS-L2FL
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2870LPS-L2FL_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-L2FL/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-L2FL/count.rds")


#######################
## 2870LPS-R1M
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2870LPS-R1M_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-R1M/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-R1M/count.rds")


#######################
## 2870LPS-R1ML
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/2870LPS-R1ML_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-R1ML/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/2870LPS-R1ML/count.rds")


#######################
## C2863
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/C2863_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/C2863/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/C2863/count.rds")


#######################
## C2864
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/C2864_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/C2864/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/C2864/count.rds")


#######################
## C2865
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/C2865_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/C2865/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/C2865/count.rds")


#######################
## C2866
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/C2866_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/C2866/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/C2866/count.rds")


#######################
## LPS2867
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/LPS2867_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/LPS2867/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/LPS2867/count.rds")


#######################
## LPS2868
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/LPS2868_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/LPS2868/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/LPS2868/count.rds")


#######################
## LPS2869
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/LPS2869_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/LPS2869/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/LPS2869/count.rds")


#######################
## LPS2870
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");
gr<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/region.rds")
exons<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/exons.rds")
ex2tx<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/ex2tx.rds")
tx2gn<-readRDS("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/tx2gn.rds")
ga<-LoadGa("/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/star/pass_2/LPS2870_Aligned.sortedByCoord.out.bam", gr, TRUE, exons, ex2tx, tx2gn, 1, -1)
saveRDS(ga, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/LPS2870/loaded.rds")
ct<-CountRead(ga, feature="gene", ncl=4, match.strand=-1)
saveRDS(ct, "/nas/is1/zhangz/projects/simmons/2016-02_RNAseq/r/load_bam/LPS2870/count.rds")


