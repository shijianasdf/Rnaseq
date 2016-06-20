fn.junc<-c(
	"ND410-B" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/ND410-B_SJ.out.tab",
	"ND410-M" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/ND410-M_SJ.out.tab",
	"ND410-T" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/ND410-T_SJ.out.tab",
	"ND422-B" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/ND422-B_SJ.out.tab",
	"ND422-M" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/ND422-M_SJ.out.tab",
	"ND422-T" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/ND422-T_SJ.out.tab",
	"ND426-B" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/ND426-B_SJ.out.tab",
	"ND430-M" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/ND430-M_SJ.out.tab",
	"ND426-T" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/ND426-T_SJ.out.tab",
	"SLE1077-B" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/SLE1077-B_SJ.out.tab",
	"SLE1077-M" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/SLE1077-M_SJ.out.tab",
	"SLE1077-T" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/SLE1077-T_SJ.out.tab",
	"SLE1169-B" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/SLE1169-B_SJ.out.tab",
	"SLE1169-M" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/SLE1169-M_SJ.out.tab",
	"SLE1169-T" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/SLE1169-T_SJ.out.tab",
	"SLE985-B" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/SLE985-B_SJ.out.tab",
	"SLE985-M" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/SLE985-M_SJ.out.tab",
	"SLE985-T" = "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/SLE985-T_SJ.out.tab"
);


library(Rnaseq);

sj<-CombineStarSj(fn.junc, output="/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab", canonical.only=0, unannotated.only=1, min.sample=2, min.unique=3, min.unique.total=10, min.overhang=5)
saveRDS(sj, "/home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/script/sj.rds")
