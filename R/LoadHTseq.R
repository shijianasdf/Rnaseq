# Load a set of HTseq output files and return a matrix
LoadHTseq<-function(fns, remove_unassigned=TRUE) {
  # fns                 String vector of name of output files from HTseq. If the strings were named, the names will be used as column names of return matrix.
  # remove_unassigned   Whether to remove reads assigned to categories "alignment_not_unique", "ambiguous", "no_feature", "not_aligned", and "too_low_aQual"
  
  ct<-lapply(fns, function(f) read.table(f, sep='\t', row=1, stringsAsFactors = FALSE)); 
  id<-sort(unique(unlist(lapply(ct, rownames), use.names=FALSE)));
  
  c<-matrix(0, nr=length(id), nc=length(ct), dimnames=list(id, names(fns))); 
  
  for (i in 1:length(ct)) c[rownames(ct[[i]]), i]<-ct[[i]][, 1]; 
  
  if (remove_unassigned) c <- c[!grepl('__', rownames(c)), ];
  
  if (is.null(colnames(c))) {
    nm<-sapply(strsplit(fns, '/'), function(x) x[length(x)]); 
    pref<-sapply(strsplit(nm, '\\.'), function(x) x[1]);
    suff<-sapply(strsplit(nm, '\\.'), function(x) x[length(x)]);
    if (length(unique(pref)) == 1) nm<-sub(paste('^', pref[1], ".", sep=''), '', nm);
    if (length(unique(suff)) == 1) nm<-sub(paste(".", suff[1], '$', sep=''), '', nm);
    colnames(c)<-nm;
  } else colnames(c)<-names(fns); 
  
  c;
}