library(devtools);
install_github("zhezhangsh/Rnaseq"); # comment out this line if the library has already been installed
library(Rnaseq);

args<-commandArgs(TRUE); # YAML file name
yaml<-yaml.load_file(args[1]);

# Input fastq files
fastq<-yaml$fastq;

# Sample names, used as prefix of output files
nm<-names(fastq);

# path to output files
path<-yaml$output;

# other run options
options<-yaml$options

# Pre-defined runnign mode requiring specific options
mode<-yaml$mode;
if (mode == 1) {
  options$twopassMode<-'None';
}

cmmd