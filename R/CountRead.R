CountRead<-function(ga.list, feature=c('gene'), ncl=1, match.strand=0) {
  # ga.list     File name (.rds) or loaded object of gapped alignment of reads loaded by the Rnaseq::LoadGa function, split by chromosomes
  # feature     Genomic feature to make the read count, such as 'exon', 'gene'
  
  require("GenomicRanges");
  require("GenomicAlignments");
  require("Rnaseq");
  
  if (class(ga.list) == 'character') {
    cat('Loading processed data of gapped alignment\n'); 
    ga.list<-readRDS(ga.list); 
  }
  
  feature<-tolower(feature);
  
  ct<-list();
  if ('gene' %in% feature) {
    cat('Calculating gene-level read count\n')
    ct$Gene<-GetGeneCount(ga.list, ncl, match.strand);
  }
  
  ct;
}

# One-on-one mapping between reads and features
GetUniqueMapping<-function(gr, read.name, feature, match.strand=0) {
  
  require("GenomicRanges");
  require("GenomicAlignments");
  require("Rnaseq");
  
  if (!feature %in% names(elementMetadata(gr))) matrix(nr=0, nc=2) else {
    df<-cbind(read.name[gr$read], as.vector(elementMetadata(gr)[, feature])); 
    
    if (match.strand<0) df<-df[!gr$same.strand, , drop=FALSE] else 
      if (match.strand>0) df<-df[gr$same.strand, , drop=FALSE]
    
    df<-df[!duplicated(df), , drop=FALSE];
    df;
  }
}

# map reads to a feature which corresponds to a column in the elementMetadata
MapRead2Feature<-function(ga.list, feature, ncl=1, match.strand=0) {
  
  require("GenomicRanges");
  require("GenomicAlignments");
  require("Rnaseq");

  paired<-ga.list[[1]]$paired;
  
  ncl<-min(ncl, length(ga.list));
  
  if (paired) { # PE
    mp.fst<-parallel::mclapply(ga.list, function(ga) GetUniqueMapping(ga[[3]][[1]], ga[[1]], feature,    match.strand), mc.cores = ncl);
    mp.lst<-parallel::mclapply(ga.list, function(ga) GetUniqueMapping(ga[[3]][[2]], ga[[1]], feature, -1*match.strand), mc.cores = ncl);
    mp<-lapply(list(mp.fst, mp.lst), function(lst) do.call('rbind', lst));
    mp<-lapply(mp, function(mp) lapply(split(mp[, 1], mp[, 2]), unique));
  } else { # SE
    mp<-parallel::mclapply(ga.list, function(ga) GetUniqueMapping(ga[[3]], ga[[1]], feature, match.strand), mc.cores = ncl);
    mp<-do.call('rbind', mp);
    mp<-lapply(split(mp[, 1], mp[, 2]), unique);
  }
  
  names(mp)<-c('first', 'last'); 
  
  mp;
}

# split unpaired/paired reads
SplitPairUnpaired<-function(mapped1, mapped2) {
  # split paired end reads and unpaired ones
  gid<-sort(unique(c(names(mapped1), names(mapped2))));
  gid<-gid[gid!='' & !is.na(gid)]; 
  pid<-cbind(mapped1[gid], mapped2[gid]);
  splt<-apply(pid, 1, function(ids) {
    id<-ids[[1]]; 
    id0<-id[id %in% ids[[2]]]; 
    id1<-c(ids[[1]], ids[[2]]); 
    id1<-id1[!(id1 %in% id0)]; 
    list(paired=id0, unpaired=id1);
  });
  names(splt)<-gid; 
}

# Gene level read count
GetGeneCount<-function(ga.list, ncl=1, match.strand=0) {

  paired<-ga.list[[1]]$paired;
  
  ##############################################################
  # Paired end reads
  if (paired) {
    ##############################################################
    # strand specific cDNA library
    if (match.strand !=0) { # strand-specific mapping
      cat('Mapping reads to genes\n');
      mapped<-MapRead2Feature(ga.list, 'gene', ncl, match.strand);  # mapped to sense strand
      mapped.anti<-MapRead2Feature(ga.list, 'gene', ncl, -1*match.strand);  # mapped to antisense strand
      
      splt<-SplitPairUnpaired(mapped[[1]], mapped[[2]]);
      mp.paired<-lapply(splt, function(mp) mp[[1]]); 
      mp.unpaired<-lapply(splt, function(mp) mp[[2]]);
      
      claimed<-c(); # reads have been assigned to a category
      ###############################################
      ###############################################      
      rds<-unlist(mp.paired, use.names=FALSE);
      gns<-rep(names(mp.paired), sapply(mp.paired, length));
      dup<-rds %in% rds[duplicated(rds)]; 
    
      ############################################  
      if (length(rds)>0) paired.unique<-split(rds[!dup], gns[!dup]) else paired.unique<-list(); # both ends of a pair mapped to one and only one gene
      ############################################  
      
      ############################################  
      if (length(rds)>0) paired.multiple<-split(rds[dup], gns[dup]) else paired.multiple<-list(); # both ends of a pair mapped to multiple genes
      ############################################  

      claimed<-c(claimed, rds);
      ################################################
      ################################################      
      # reads mapped to antisense strand
      splt<-SplitPairUnpaired(mapped.anti[[1]], mapped.anti[[2]]);
      anti.paired<-lapply(splt, function(mp) mp[[1]]);
      anti.unpaired<-lapply(splt, function(mp) mp[[2]]);
      
      rds<-unlist(anti.paired, use.names=FALSE);
      gns<-rep(names(anti.paired), sapply(anti.paired, length));
      cld<-rds %in% claimed;
      rds<-rds[!cld];
      gns<-gns[!cld];
      dup<-rds %in% rds[duplicated(rds)]; 
      
      ############################################  
      if (length(rds)>0) paired.unique.anti<-split(rds[!dup], gns[!dup]) else paired.unique.anti<-list(); # both paired mapped to the antisense of one and only one gene
      ############################################  
      
      ############################################  
      if (length(rds)>0) paired.multiple.anti<-split(rds[dup], gns[dup]) else paired.multiple.anti<-list(); # both paired mapped to the antisense of one and only one gene
      ############################################  
      
      claimed<-c(claimed, rds);
      ################################################
      ################################################      
      rds<-unlist(mp.unpaired, use.names=FALSE);
      gns<-rep(names(mp.unpaired), sapply(mp.unpaired, length));
      cld<-rds %in% claimed;
      rds<-rds[!cld];
      gns<-gns[!cld];
      dup<-rds %in% rds[duplicated(rds)];  
      
      ############################################  
      if (length(rds)>0) unpaired.unique<-split(rds[!dup], gns[!dup]) else unpaired.unique<-list(); # unpaired reads mapped to one and only one gene
      ############################################  
      
      ############################################  
      if (length(rds)>0) unpaired.multiple<-split(rds[dup], gns[dup]) else unpaired.multiple<-list(); # unpaired reads mapped to multiple genes
      ############################################  
      
      claimed<-c(claimed, rds);
      ################################################
      ###############################################      
      rds<-unlist(anti.unpaired, use.names=FALSE);
      gns<-rep(names(anti.unpaired), sapply(anti.unpaired, length));
      cld<-rds %in% claimed;
      rds<-rds[!cld];
      gns<-gns[!cld];
      dup<-rds %in% rds[duplicated(rds)]; 
      
      ############################################  
      if (length(rds)>0) unpaired.unique.anti<-split(rds[!dup], gns[!dup]) else unpaired.unique.anti<-list(); # unpaired reads mapped to the antisense of one and only one gene
      ############################################  
      
      ############################################  
      if (length(rds)>0) unpaired.multiple.anti<-split(rds[dup], gns[dup]) else unpaired.multiple.anti<-list(); # unpaired reads mapped to the antisense of one and only one gene
      ############################################  
      
      claimed<-c(claimed, rds);
      
      grps<-list(paired.unique, paired.multiple, unpaired.unique, unpaired.multiple, paired.unique.anti, paired.multiple.anti, unpaired.unique.anti, unpaired.multiple.anti); 
      names(grps)<-c('unique', 'multiple', 'unpaired_unique', 'unpaired_multiple', 
                     'unique_antisense', 'multiple_antisense', 'unpaired_unique_antisense', 'unpaired_multiple_antisense');
    } else { 
      ##############################################################
      # strand non-specific cDNA library  
      # TODO
      grps<-list();
    }
  } else { # unpaired reads
    # TODO
    grps<-list();
  }
  
  # Count reads
  ct<-lapply(grps, function(gp) sapply(gp, length));
  gid<-sort(unique(unlist(lapply(ct, names), use.names=FALSE)));
  c<-matrix(0, nr=length(gid), nc=length(grps), dimnames = list(gid, names(grps)));
  if (length(grps)>0) for (i in 1:length(grps)) if (length(ct[[i]])>0) c[names(ct[[i]]), i]<-ct[[i]];
  
  list(count=c, mapping=grps);
}

# Combine multiple tables of counts
CombineCounts<-function(fns, nms=names(fns)) {
  # fns   File names
  
  cts<-lapply(fns, readRDS);
  
  rnm<-sort(unique(unlist(lapply(cts, rownames), use.names=FALSE))); 
  cnm<-unique(unlist(lapply(cts, colnames), use.names=FALSE));
  
  c1<-lapply(cts, function(ct) {
    mtrx<-matrix(0, nr=length(rnm), nc=length(cnm), dimnames=list(rnm, cnm)); 
    mtrx[rownames(ct), colnames(ct)]<-ct; 
    mtrx; 
  }); 
  
  ct<-lapply(cnm, function(nm) sapply(c1, function(c) c[, nm])); 
  for (i in 1:length(ct)) colnames(ct[[i]])<-nms;
  names(ct)<-cnm; 
  
  ct; 
}



