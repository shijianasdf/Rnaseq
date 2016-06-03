# Map exons to genes and generate annotation table of genes
MapExon2Gene <- function(gr, cnm.tx, cnm.gn) {
  # gr      GRanges object of all exons, with elementMetadata specifying the transcript and gene each exon belongs to
  # cnm.tx  Column name of the transcripts
  # cnm.gn  Column name of the genes
  
  require("GenomicRanges");
  
  meta <- elementMetadata(gr); 
  cnm.tx <- cnm.tx[1];
  cng.gn <- cnm.gn[1];
  
  if (!(cnm.tx %in% names(meta))) stop('No column of transcripts named ', cnm.tx, ' is found in element metadata.\n');
  if (!(cnm.gn %in% names(meta))) stop('No column of genes named ', cnm.tx, ' is found in element metadata.\n');
  
  tx <- as.vector(meta[, cnm.tx]); 
  gn <- as.vector(meta[, cnm.gn]); 
  tx[is.na(tx) | tx==''] <- gn[is.na(tx) | tx=='']; 
  
  # Exon IDs
  ex <- names(gr); 
  if (is.null(ex)) ex <- paste('exon', 1:length(ex), sep='_'); 
  ind <- which(is.na(ex) | ex==''); 
  if (length(ind) > 0) ex[ind] <- paste('exon', ind, sep='_'); 
  
  chr <- as.vector(seqnames(gr)); 
  len <- width(gr); 
  names(len) <- ex; 
  
  tx2ex <- split(len, tx);
  tx.len <- sapply(tx2ex, sum); 
  tx.chr <- lapply(split(chr, tx), unique); 
  
  mp <- lapply(split(tx, gn), unique); 
  num.tx <- sapply(mp, length); 
  mp.gn <- rep(names(mp), num.tx); 
  mp.tx <- unlist(mp, use.names=FALSE); 
  mp.len <- split(tx.len[mp.tx], mp.gn); 
  len.min <- sapply(mp.len, min); 
  len.max <- sapply(mp.len, max);
  len.mean <- sapply(mp.len, mean); 
  
  gn.chr <- tx.chr[mp.tx];
  nchr <- sapply(gn.chr, length); 
  gn.chr <- split(unlist(gn.chr, use.names=FALSE), rep(mp.gn, nchr)); 
  gn.chr <- sapply(gn.chr, function(x) paste(unique(x), collapse=';')); 
  gn.id <- names(mp); 
  
  anno <- data.frame(chromosome = gn.chr[gn.id], length=len.mean[gn.id], num_transcript=num.tx[gn.id], 
                     length_min=len.min[gn.id], length_max=len.max[gn.id], stringsAsFactors = FALSE); 
  rownames(anno) <- gn.id;
  
  mp.all <- split(tx2ex[mp.tx], mp.gn); 
  
  list(gene=anno, transcript=list(length=tx.len, chromosome=tx.chr), mapping=mp.all); 
}