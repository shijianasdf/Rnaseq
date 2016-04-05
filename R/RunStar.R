# Run STAR based on inputs defined by a .yaml file
RunStar<-function(fn.yaml) {
  # fn.yaml   Name of the .yaml file defines the run inputs
  
  library(yaml);
  yaml<-yaml.load_file(fn.yaml);
  
  execute<-yaml$execute; # Just save the shell script if FALSE; run STAR alignment if TRUE
  will.qsub<-yaml$qsub$will;  # Whether to execute with qsub. Generate script within a subfolder scripts if TRUE
  qsub.path<-c(yaml$qsub$path$from, yaml$qsub$path$to); 
  qsub.pre<-yaml$qsub$prefix;

  # Combination of junction sites
  junc<-yaml$junction
  
  # Input fastq files
  fastq<-yaml$fastq;
  
  # Sample names, used as prefix of output files
  nms<-names(fastq);
  
  # path to output files
  path<-yaml$output;
  if (!file.exists(path)) dir.create(path, recursive=TRUE);
  
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
    if (will.qsub) {
      names(lines)<-nms;
      fn<-sapply(nms, function(nm) {
        fn<-paste(path.pass[i], '/STAR_', nm, '.sh', sep='');
        l<-lines[[nm]]; 
        l<-gsub(qsub.path[1], qsub.path[2], l);
        writeLines(l, fn);
        fn;
      });
      writeLines(paste(qsub.pre, sub(qsub.path[1], qsub.path[2], fn)), paste(path.pass[i], 'qsub.sh', sep='/')); 
    }
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
  
  cmmd<-lapply(cmmd, function(cmmd) sapply(cmmd, function(cmmd) paste(cmmd[-(1:2)], collapse=' ')));
  names(cmmd)<-paste('pass', 1:length(cmmd), sep='');

  ############################################################################################################################################
  ############################################################################################################################################
  # Make the actual runs
  if (execute) {
    # Keep track of process
    fn.log<-paste(path, 'log.rds', sep='/'); 
    if (!file.exists(fn.log)) {
      log<-lapply(1:length(cmmd), function(i) rep(FALSE, length(nms)));
      saveRDS(log, file=fn.log); 
    } else {
      log<-readRDS(fn.log);
      if (length(log) < length(cmmd)) {
        log[(length(log)+1):length(cmmd)]<-lapply((length(log)+1):length(cmmd), function(i) rep(FALSE, length(nms)));
        saveRDS(log, file=fn.log);
      }
    };
    
    for (i in 1:length(cmmd)) { # For each pass
      for (j in 1:length(nms)) { # For each sample
        c<-cmmd[[i]][[j]]; # The command to run
        
        fn.req<-unlist(c(yaml$star, yaml$output, yaml$options$genomeDir, yaml$fastq[[j]]));
        if (!is.null(yaml$options$sjdbGTFfile)) fn.req<-c(fn.req, yaml$options$sjdbGTFfile);
        fn.req<-fn.req[!file.exists(fn.req)];
        if (i > 1) fn.sj<-paste(path.pass[i-1], '/', nms, '_SJ.out.tab', sep='') else fn.sj<-character();
        fn.sj<-fn.sj[!file.exists(fn.sj)];
        fn.req<-c(fn.req, fn.sj);
        
        if (length(fn.req) > 0) {
          w<-warning("Required file(s) not exist: \n", paste(fn.req, collapse='\n'));
          cat(c('\n', '\n', date(), '\n', w), file=paste(yaml$output, 'RunStar.log', sep='/'), append=TRUE);
        } else if (log[[i]][[j]]) {
          cat(c('\n', '\n', date(), '\n', nms[j], ', pass', i, ': already aligned.\n'), file=paste(yaml$output, 'RunStar.log', sep='/'), append=TRUE);
        } else {
          cat('Running alignment;', 'sample:', nms[j], '; pass', i, '\n');
          ##########################################################################################
          cd<-system(c, intern=FALSE, ignore.stdout=TRUE, ignore.stderr=TRUE, wait=TRUE); # Run STAR
          ##########################################################################################
          
          # Run succeeded
          if (cd == 0) {
            log[[i]][[j]]<-TRUE;
            saveRDS(log, file=fn.log);
            cat(c('\n', '\n', date(), '\n', 'Finished alignment:', nms[j], 'pass', i, '\n'), file=paste(yaml$output, 'RunStar.log', sep='/'), append=TRUE);
          }
        }
      } # end of for each sample
      # Delete intermediate SAM files
      fn.sam<-dir(path.pass[i]);
      fn.sam<-fn.sam[grep('Aligned.out.sam', fn.sam)];
      if (length(fn.sam) > 0) file.remove(paste(path.pass[i], fn.sam, sep='/'));
      
    } # End of for (i in 1:length(log))
  }
  
  # Prepare yaml file for summarizing STAR alignment
  if (!is.null(yaml$template)) yml.smm<-list(template=yaml$template) else 
    yml.smm<-list(template="https://raw.githubusercontent.com/zhezhangsh/Rnaseq/master/examples/SummarizeStar/SummarizeStar.Rmd") 
  yml.smm<-c(yml.smm, yaml[c('star', 'samtools', 'output', 'pass', 'junction', 'qsub', 'options')]); 
  yml.smm$file<-lapply(names(fastq), function(nm) {
    list(fastq=fastq[[nm]], 
         bam=paste(path, paste('pass', n, sep='_'), paste(nm, '_Aligned.sortedByCoord.out.bam', sep=''), sep='/'),
         log=paste(path, paste('pass', n, sep='_'), paste(nm, '_Log.final.out', sep=''), sep='/'))
  }); 
  names(yml.smm$file)<-names(fastq);
  path.summ<-paste(path, 'summarize_star', sep='/'); 
  if (!file.exists(path.summ)) dir.create(path.summ, recursive = TRUE); 
  writeLines(as.yaml(yml.smm), paste(path.summ, 'summarize_star.yml', sep='/')); 
  
  cmmd;
}


# Summarize log of STAR outputs of a set of RNA-seq libraries
CreateStarReport<-function(yml) {
  # yml     The yaml file or an yaml list defines the STAR runs
  
  if (class(yml) == 'character') {
    if (!file.exists(yml)) stop('Input file', yml, 'not found\n'); 
    yml <- yaml::yaml.load_file(yml);  
  }
  
  library(knitr);
  library(rmarkdown); 
  
  if (!file.exists(yml$output)) dir.create(yml$output, recursive = TRUE)
  fn.html<-paste(yml$output, 'SummarizeStar.html', sep='/'); 
  fn.temp<-paste(yml$output, 'SummarizeStar.Rmd', sep='/'); 
  
  if (grepl('^http', yml$template)) {
    writeLines(RCurl::getURL(yml$template)[[1]], fn.temp);
  } else {
    file.copy(yml$input$template, fn.temp); 
  }
  
  errors<-try(rmarkdown::render(fn.temp, output_format="html_document", output_file='SummarizeStar.html', output_dir=yml$output, 
                                quiet=TRUE, envir=new.env()), silent=TRUE);
  
  writeLines(yaml::as.yaml(yml), paste(yml$output, 'SummarizeStar.yml', sep='/'));   
  
  list(index=fn.html, error=errors);
}

