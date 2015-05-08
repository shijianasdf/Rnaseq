# Generate a command line that performs a STAR alignment; optionally execute the command
StarAlignment<-function(fastq1, fastq2=NA, output.prefix, options, execute=FALSE) {
  # fastq1, fastq2  Fastq files of a sample
  # output.prefix   Path to the output files
  # options         The run options; as name-value pairs
  # execute         If TRUE, run the command line using the R system() function; just return the command line otherwise
  
  library(yaml);
  library(RCurl);
  
  if (grepl('^http', fn.yaml)) yaml<-yaml.load(getURL(yaml)) else yaml<-yaml.load_file(fn.yaml);
  
  # Build command line
  cmmd<-yaml$star;
  
  # Input file names
  if (is.na(fastq2[1])) fn<-fastq1[1] else fn<-paste(fastq1[1], fastq2[1]);
  cmmd<-paste(cmmd, "--readFilesIn", fn);
  
  cmmd<-paste(cmmd, "--outFileNamePrefix", output.prefix);
  
  # Append options
  # options<-yaml$options;
  cmmd<-paste(cmmd, paste(paste(paste('--', names(options), sep=''), as.vector(options)), collapse=' '));
  
  if (execute) system(cmmd);
  
  cmmd;
}