ProcessRnaseq <- function(fn.yaml) {
  
  require(Rsamtools);
  require(yaml);
  yaml<-yaml.load_file(fn.yaml);
  
  # path to output files
  path<-yaml$output;
  if (!grepl('^/', path)) path <- paste(getwd(), path, sep='/'); 
  if (!file.exists(path)) dir.create(path, recursive=TRUE);

  # Combination of junction sites
  junc<-yaml$junction
  
  # Input fastq files
  fastq<-yaml$fastq;
  nms<-names(fastq);
  
  # other run options
  options<-yaml$options
  options$twopassMode<-'None'; # Turn off the default persample 2-pass mapping mode
  
  # Pre-defined runnign mode requiring specific options
  n<-as.integer(yaml$pass[1]);
  if (n<1) n<-1;
  path.pass<-paste(path, '/pass_', 1:n, sep='');
  path.pass<-gsub('//', '/', path.pass);
  sapply(path.pass, function(path) if (!file.exists(path)) dir.create(path))->x; 
  
  ############################################################################################################################################
  ############################################################################################################################################
  # create command lines
  cmmd<-lapply(1:n, function(i) {
    lines<-lapply(nms, function(nm) {
      ln<-c('############', paste('#', nm), yaml$star);
      
      # Add fastq file(s)
      if (is.na(fastq[[nm]]$fastq2) | is.null(fastq[[nm]]$fastq2)) fn<-fastq[[nm]]$fastq1 else fn<-paste(fastq[[nm]]$fastq1, fastq[[nm]]$fastq2);
      ln<-c(ln, paste("--readFilesIn", fn));
      
      ln<-c(ln, paste("--genomeDir", yaml$genome)); 
      ln<-c(ln, paste("--sjdbGTFfile", yaml$transcriptome)); 
      
      # Add other options
      if (i == length(path.pass)) options$outSAMtype<-"BAM SortedByCoordinate";
      ln<-c(ln, as.vector(sapply(names(options), function(op) if (!is.null(options[[op]])) paste('--', op, ' ', as.vector(options[[op]]), sep='') else '')));
      
      # Add output path and prefix
      ln<-c(ln, paste("--outFileNamePrefix ", path.pass[i], '/', nm, '_', sep=''));
      
      # Add SJ files created by the last pass
      if (i > 1) {
        if (junc$combine) fn.sj<- paste(path.pass[i-1], junc$filename, sep='/') else 
          fn.sj<-paste(path.pass[i-1], '/', nms, '_SJ.out.tab', sep='');
        ln<-c(ln, paste(c("--sjdbFileChrStartEnd", fn.sj), collapse=' '));
      }
      
      if (length(ln) > 3) ln[3:(length(ln)-1)]<-paste(ln[3:(length(ln)-1)], '\\');
      
      if (i == n) {
        l<-paste(yaml$samtools, 'index', paste(path.pass[i], '/', nm, '_Aligned.sortedByCoord.out.bam', sep='')); 
        ln<-c(ln, '', l, '');
      }
      c(ln, '', '');
    });
    writeLines(unlist(lines, use.names=FALSE), paste(path.pass[i], 'RunStar.sh', sep='/'));
    
    ############################################################################################################################################
    # Prepare command for qsub run
    qsub.path<-paste(path.pass[i], 'qsub', sep='/'); 
    if (!dir.exists(qsub.path)) dir.create(qsub.path); 
    names(lines)<-nms;
    fn<-sapply(nms, function(nm) {
      fn<-paste(qsub.path, '/STAR_', nm, '.sh', sep='');
      l<-lines[[nm]]; 
      writeLines(l, fn);
      fn;
    });
    writeLines(paste(yaml$qsub, fn), paste(path.pass[i], 'qsub.sh', sep='/')); 
    
    ############################################################################################################################################
    
    ############################################################################################################################################
    # Prepare helper script
    path.script<-paste(path.pass[i], 'script', sep='/');
    if (!file.exists(path.script)) dir.create(path.script, recursive=TRUE);
    fn.sam<-paste(path.pass[i], '/', nms, '_Aligned.out.sam',  sep=''); 
    fn.sam<-sub(qsub.path[1], qsub.path[2], fn.sam);
    writeLines(paste('rm', fn.sam), paste(path.script, 'delete_sam.sh', sep='/')); 
    
    fn.junc<-paste(path.pass[i], '/', nms, '_SJ.out.tab',  sep=''); 
    fn.junc<-sub(qsub.path[1], qsub.path[2], fn.junc);
    fn.junc<-paste('"', fn.junc, '"', sep=''); 
    fn.junc<-paste('\t"', nms, '" = ', fn.junc, sep=''); 
    lns<-paste(fn.junc, collapse=',\n');
    lns<-c('fn.junc<-c(', lns, ');', '\n\nlibrary(Rnaseq);\n');  
    if (i>1) junc$unannotated<-FALSE
    l<-paste(c('canonical.only', 'unannotated.only', 'min.sample', 'min.unique', 'min.unique.total', 'min.overhang'), 
             c(junc$canonical, junc$unannotated, junc$minimum$sample, junc$minimum$read, junc$minimum$total, junc$minimum$overhang), sep='=');
    l<-paste(l, collapse=', '); 
    l<-paste('"', paste(path.pass[i], junc$filename, sep='/'), '", ', l, sep=''); 
    l<-paste('sj<-CombineStarSj(fn.junc, output=', l, ')', sep=''); 
    lns<-c(lns, l); 
    l<-paste('saveRDS(sj, "', paste(path.script, 'sj.rds', sep='/'), '")', sep=''); 
    lns<-c(lns, l);
    lns<-gsub(qsub.path[1], qsub.path[2], lns); 
    writeLines(lns, paste(path.script, 'combined_junction.r', sep='/')); 
    ############################################################################################################################################
    
    lines;
  });
  
  # cmmd<-lapply(cmmd, function(cmmd) sapply(cmmd, function(cmmd) paste(cmmd[-(1:2)], collapse=' ')));
  # names(cmmd)<-paste('pass', 1:length(cmmd), sep='');
  
  ############################################################################################################################################
  # Prepare yaml file for summarizing STAR alignment
  path.smm <- paste(path, 'summarize_star', sep='/'); 
  if (!dir.exists(path.smm)) dir.create(path.smm); 
  fn.yaml1 <- DownloadFile(yaml$summarize, path = path.smm); 
  yaml1 <- yaml.load_file(fn.yaml1); 
  
  fn.log <- paste(path, paste('pass', n, sep='_'), paste(nms, '_Log.final.out', sep=''), sep='/');
  names(fn.log) <- nms; 
  
  yaml1$output <- path.smm;
  yaml1$home <- yaml$home;
  yaml1$analyst <- yaml$analyst;
  yaml1$description <- yaml$description;
  yaml1$input <- as.list(fn.log);
  yaml1$parameter$program <- yaml$star; 
  yaml1$parameter$output <- path.pass[n];
  yaml1$parameter$genome <- yaml$genome;
  yaml1$parameter$transcriptome <- yaml$transcriptome;
  yaml1$parameter$star <- yaml$options;
  writeLines(as.yaml(yaml1), fn.yaml1); 

  ############################################################################################################################################
  # Prepare yaml file for loading bam file into R
  path.load <- paste(path, 'load_bam', sep='/'); 
  if (!dir.exists(path.load)) dir.create(path.load);
  
  fn.bam <- paste(path, paste('pass', n, sep='_'), paste(nms, '_Aligned.sortedByCoord.out.bam', sep=''), sep='/');
  names(fn.bam) <- nms;
  
  yaml2 <- list();
  
  fn <- sapply(names(fn.bam), function(nm) {
    pth<-paste(path.load, nm, sep='/');
    if (!file.exists(pth)) dir.create(pth, recursive = TRUE); 
    fn.r<-paste(pth, 'LoadBam.r', sep='/'); 
    fn.sh<-paste(pth, 'LoadBam.sh', sep='/'); 
    fn.yml<-paste(pth, 'LoadBam.yml', sep='/'); 
    
    y<-list(name=nm, bam=fn.bam[[nm]]); 
    yml<-c(y, yaml2); 
    writeLines(as.yaml(yml), fn.yml); 
    
    writeLines(paste(yml$R, fn.r), fn.sh); 
    
    lns<-c(paste('##', nm), 'require("GenomicRanges");', 'require("GenomicAlignments");', 'require("Rnaseq");', '');
    lns<-c(lns, paste('fn.yaml <- ("', fn.yml, '");', sep=''));
    lns<-c(lns, 'ct<-LoadBam(fn.yaml);', '');
    writeLines(lns, fn.r); 
    
    fn.sh;
  });
}