args<-commandArgs(TRUE); # YAML file name

# read in the .yaml file
library(yaml);
yaml<-yaml.load_file(args[1]);

# Input fastq files
fastq<-yaml$fastq;

# Sample names, used as prefix of output files
nm<-names(fastq);

# path to output files
path<-yaml$output;
if (!file.exists(path)) dir.create(path, recursive=TRUE);

# other run options
options<-yaml$options

# Pre-defined runnign mode requiring specific options
mode<-yaml$mode;
if (mode == 1 | mode == 2) { # run the 2nd pass explicitly
  options$twopassMode<-'None';
} 

# create command line for pass 1
cmmd<-sapply(nm, function(nm) {
  fq1<-fastq[[nm]]$fastq1;
  fq2<-fastq[[nm]]$fastq2;
  
  # Build command line
  cmmd<-yaml$star;
  
  # Input file names
  if (is.na(fq2) | is.null(fq2)) fn<-fq1 else fn<-paste(fq1, fq2);
  cmmd<-paste(cmmd, "--readFilesIn", fn);
  cmmd<-paste(cmmd, "--outFileNamePrefix", paste(path, '/', nm, '_', sep=''));
  cmmd<-paste(cmmd, paste(paste(paste('--', names(options), sep=''), as.vector(options)), collapse=' '));
  cmmd;
});

# create command lines for pass 2
if(mode==2) {
  fn.sj<-paste(path, dir(yaml$output), sep='/');
  fn.sj<-fn.sj[grep('_SJ.out.tab$', fn.sj)];
  cmmd2<-sapply(nm, function(nm) {
    fq1<-fastq[[nm]]$fastq1;
    fq2<-fastq[[nm]]$fastq2;
    
    # Build command line
    cmmd<-yaml$star;
    
    # Input file names
    if (is.na(fq2) | is.null(fq2)) fn<-fq1 else fn<-paste(fq1, fq2);
    cmmd<-paste(cmmd, "--readFilesIn", fn);
    cmmd<-paste(cmmd, "--outFileNamePrefix", paste(path, '/pass2/', nm, '_', sep=''));
    cmmd<-paste(cmmd, paste(paste(paste('--', names(options), sep=''), as.vector(options)), collapse=' '));
    cmmd<-paste(cmmd, '--sjdbFileChrStartEnd', paste(fn.sj, collapse=' '));
    cmmd;
  });
  
  cmmd<-c(cmmd, '', '', cmmd2);
}

# Save shell script
if (is.na(args[2])) fn<-'./RunStar.sh' else fn<-args[2];
writeLines(paste(cmmd, collapse='\n\n'),  fn);

