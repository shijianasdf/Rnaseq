args<-commandArgs(TRUE); # YAML file name

require(yaml);
require("GenomicRanges");
require("GenomicAlignments");
require("Rnaseq");

# read in the .yaml file
yaml<-yaml.load_file(args[1]);

nm<-yaml$name;
bam<-yaml$path.bam;
out<-yaml$path.out;

if (is.null(yaml$region)) gr<-NA else {
  gr<-GRanges(names(yaml$region), IRanges(sapply(yaml$region, min), sapply(yaml$region, max)));
}

paired<-yaml$paired;
min.mapq<-yaml$min.mapq;
strand.match<-yaml$strand.match;
wht<-yaml$what;

exons<-readRDS(yaml$path.exon);
cnm<-colnames(elementMetadata(exons));
if ("transcript_id" %in% cnm) {
  ex2tx<-as.vector(exons$transcript_id);
  names(ex2tx)<-names(exons);
} else ex2tx<-NA;

if ("gene_id" %in% cnm & "transcript_id" %in% cnm) {
  tx2gn<-as.vector(exons$gene_id);
  names(tx2gn)<-as.vector(exons$transcript_id);
  tx2gn<-tx2gn[!duplicated(names(tx2gn))];
} else tx2gn<-NA;

ga<-LoadGa(bam, gr, paired, exons, ex2tx, tx2gn, min.mapq, strand.match);

saveRDS(ga, paste(out, '/', nm, '.rds', sep='')); 
