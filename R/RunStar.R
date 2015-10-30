# Run STAR based on inputs defined by a .yaml file
RunStar<-function(fn.yaml, execute=FALSE, will.qsub=FALSE, qsub.path=c('/nas/is1', '/mnt/isilon/cbmi/variome')) {
  # fn.yaml   Name of the .yaml file defines the run inputs
  # execute   Just save the shell script if FALSE; run STAR alignment if TRUE
  # will.qsub Whether to execute with qsub. Generate script within a subfolder scripts if TRUE
  
  library(yaml);
  yaml<-yaml.load_file(fn.yaml);
  
  # Input fastq files
  fastq<-yaml$fastq;
  
  # Sample names, used as prefix of output files
  nms<-names(fastq);
  
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
  
  ######################################################################################################################################
  ######################################################################################################################################
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
        fn.sj<-paste(path.pass[i-1], '/', nms, '_SJ.out.tab', sep='');
        ln<-c(ln, paste(c("--sjdbFileChrStartEnd", fn.sj), collapse=' '));
      }
      
      if (length(ln) > 3) ln[3:(length(ln)-1)]<-paste(ln[3:(length(ln)-1)], '\\');
      c(ln, '', '');
    });

    ############################################################################################################################################
    # Prepare command for qsub run
    if (will.qsub) {
      #path.qsub<-paste(path.pass[i], 'qsub', sep='/');
      #if (!file.exists(path.qsub)) dir.create(path.qsub);
      names(lines)<-nms;
      fn<-sapply(nms, function(nm) {
        fn<-paste(path.pass[i], '/STAR_', nm, '.sh', sep='');
        l<-lines[[nm]]; 
        l<-gsub(qsub.path[1], qsub.path[2], l);
        #ind<-grep("^--outFileNamePrefix ", l);
        #if (length(ind)>0) l[ind]<-paste("--outFileNamePrefix ", path.pass[i], '/qsub/', nm, '_', sep='')
        writeLines(l, fn);
        #paste(nm, 'sh', sep='.');
      });
      #l<-paste(paste('qsub', fn), collapse='; ');
      #writeLines(l, paste(path.qsub, 'qsub', sep='/'));
    }
    ############################################################################################################################################
    
    writeLines(unlist(lines, use.names=FALSE), paste(path.pass[i], 'RunStar.sh', sep='/'));
    
    lines;
  });
  
  names(cmmd)<-paste('pass', 1:length(cmmd), sep='');
  cmmd<-lapply(cmmd, function(cmmd) sapply(cmmd, function(cmmd) paste(cmmd[-(1:2)], collapse=' ')));
  
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
  
  cmmd;
}
