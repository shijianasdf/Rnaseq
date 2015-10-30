# Convert SAM files to BAM files, sort and index the BAM files, using a .yaml file to define the inputs
ConvertSam2Bam<-function(yaml, path.out=getwd(), execute=FALSE, split=FALSE) {
  # yaml      A .yaml file defining the inputs, including a list of SAM file names
  # path.out  Path to files of samtools script
  # execute   Return command lines only if FALSE; execute the code if TRUE
  # split     Whether to split command lines by SAM files
  
  if (!file.exists(yaml)) stop('YAML file:', yaml, 'not exist.\n');
  y<-yaml::yaml.load_file(yaml);
  
  sam<-sapply(y$sam, function(x) x[1]);
  nm<-names(sam); 
  bam<-sub('.sam$', '.bam', sam);
  
  # SAM to BAM
  cmmd1<-paste(y$samtools, 'view', y$view, sam, '>', bam);
  
  # sort BAM
  cmmd2<-paste(y$samtools, 'sort', y$sort, bam, sub('.bam$', '.sorted', bam));
  
  # index BAM
  cmmd3<-paste(y$samtools, 'index', sub('.bam$', '.sorted.bam', bam));
  
  cmmd<-lapply(1:length(nm), function(i) c(paste('#', nm[i]), cmmd1[i], cmmd2[i], cmmd3[i], ''));
  names(cmmd)<-nm;
  
  cmmd0<-unlist(cmmd, use.names=FALSE);
  if (!file.exists(path.out)) dir.create(path.out, recursive = TRUE);
  writeLines(cmmd0, paste(path.out, 'sam2bam.sh', sep='/'));
  
  out<-cmmd;
  
  if (execute) {
    cmmd0<-cmmd0[cmmd0 != ''];
    out<-lapply(cmmd0, system); 
  }
  
  if (split) {
    pth<-paste(path.out, 'sam2bam', sep='/');
    if (!file.exists(pth)) dir.create(pth, recursive = TRUE);
    
    fn<-sapply(names(cmmd), function(nm) {
      fn<-paste(path.out, 'sam2bam', paste(nm, '.sh', sep=''), sep='/'); 
      writeLines(cmmd[[nm]], fn); 
      fn;
    }); 
    
    out<-fn;
  }
  
  out;
}
