# Generate a command line that performs a STAR alignment; optionally execute the command
StarAlignment<-function(fastq1, fastq2=NA, output.prefix, fn.yaml, execute=FALSE) {
  # fastq1, fastq2  Fastq files of a sample
  # output.prefix   Path and file name prefix of the output files
  # fn.yaml            .yaml file that provides the run options; required a field called 'star' to the full path of the STAR program
  # execute         If TRUE, run the command line using the R system() function; just return the command line otherwise
  
  library(yaml);
  if (grepl('^http', fn.yaml)) yaml<-yaml.load(getURL(yaml)) else yaml<-yaml.load_file(fn.yaml);
  
  # Build command line
  cmmd<-yaml$star;
  
  # Input file names
  if (is.na(fastq2[1])) fn<-fastq1[1] else fn<-paste(fastq1[1], fastq2[1]);
  cmmd<-paste(cmmd, "--readFilesIn", fn);
  
  cmmd<-paste(cmmd, "--outFileNamePrefix", output.prefix);
  
  # Append options
  options<-yaml$options;
  cmmd<-paste(cmmd, paste(paste(paste('--', names(options), sep=''), as.vector(options)), collapse=' '));
}