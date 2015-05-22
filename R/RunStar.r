RunStar<-function(fn.yaml, execute=FALSE) {
  # fn.yaml   Name of the .yaml file defines the run inputs
  
  library(yaml);
  yaml<-yaml.load_file(fn.yaml);
  
  # Input fastq files
  fastq<-yaml$fastq;
  
  # Sample names, used as prefix of output files
  nm<-names(fastq);
  
  # path to output files
  path<-yaml$output;
  if (!file.exists(path)) dir.create(path, recursive=TRUE);
  
  # other run options
  options<-yaml$options
  options$twopassMode<-'None'; # Turn off the persample 2-pass mapping mode
  
  # Pre-defined runnign mode requiring specific options
  n<-as.integer(yaml$pass[1]);
  if (n<1) n<-1;
  path.pass<-paste(path, '/pass_', 1:n, sep='');
  path.pass<-gsub('//', '/', path.pass);
  sapply(path.pass, function(path) if (!file.exists(path)) dir.create(path))->x; 
  
  # create command lines
  cmmd<-lapply(1:n, function(i) {
    lines<-lapply(nm, function(nm) {
      ln<-c('############', paste('#', nm), yaml$star);
   
      # Add fastq file(s)
      if (is.na(fastq[[nm]]$fastq2) | is.null(fastq[[nm]]$fastq2)) fn<-fastq[[nm]]$fastq1 else fn<-paste(fastq[[nm]]$fastq1, fastq[[nm]]$fastq2);
      ln<-c(ln, paste("--readFilesIn", fn));
      
      # Add other options
      ln<-c(ln, as.vector(sapply(names(options), function(op) paste('--', op, ' ', as.vector(options[[op]]), sep=''))));
      
      # Add output path and prefix
      ln<-c(ln, paste("--outFileNamePrefix ", path.pass[i], '/', nm, '_', sep=''));
      
      # Add SJ files created by the last pass
      if (i > 1) {
        fn.sj<-dir(path.pass[i-1]);
        fn.sj<-paste(path.pass[i-1], fn.sj[grep('SJ.out.tab$', fn.sj)], sep='/');
        ln<-c(ln, paste(c("--sjdbFileChrStartEnd", fn.sj), collapse=' '));
      }
      
      if (execute) system(paste(ln[-(1:2)], collapse=' '));
      
      c(ln, '', '');
    });
    
    writeLines(paste(unlist(lines, use.names=FALSE), '\\'), paste(path.pass[i], 'RunStar.sh', sep='/'));
    
    lines;
  });
  
  names(cmmd)<-paste('pass', 1:length(cmmd), sep='');
  cmmd<-lapply(cmmd, function(cmmd) sapply(cmmd, function(cmmd) paste(cmmd[-(1:2)], collapse=' ')));
  
  cmmd;
}
