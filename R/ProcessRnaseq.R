# Generate scripts to process a RNA-seq data set
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
  options<-yaml$alignment
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
      writeLines(as.vector(unlist(l)), fn);
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

  ############################################################################################################################################
  ############################################################################################################################################
  # Prepare yaml file for summarizing STAR alignment
  path.smm <- paste(path, 'summarize_star', sep='/'); 
  if (!dir.exists(path.smm)) dir.create(path.smm); 
  fn.yaml1 <- DownloadFile(yaml$summarize, path = path.smm); 
  yaml1 <- yaml.load_file(fn.yaml1); 
  
  fn.log <- paste(path, paste('pass', n, sep='_'), paste(nms, '_Log.final.out', sep=''), sep='/');
  names(fn.log) <- nms; 
  
  yaml1$output <- paste(yaml$result, 'summarize_star', sep='/');
  yaml1$home <- yaml$home;
  yaml1$analyst <- yaml$analyst;
  yaml1$zip <- TRUE; 
  yaml1$description <- yaml$description;
  yaml1$input <- as.list(fn.log);
  yaml1$parameter$program <- yaml$star; 
  yaml1$parameter$output <- path.pass[n];
  yaml1$parameter$genome <- yaml$genome;
  yaml1$parameter$transcriptome <- yaml$transcriptome;
  yaml1$parameter$star <- yaml$alignment;
  writeLines(as.yaml(yaml1), fn.yaml1); 
  
  writeLines(paste("RoCA::CreateReport(\"", fn.yaml1, "\");", sep=''), sub('.yaml$', '.r', fn.yaml1)); 
  writeLines(paste(yaml$R, sub('.yaml$', '.r', fn.yaml1)), sub('.yaml$', '.sh', fn.yaml1));

  ############################################################################################################################################
  ############################################################################################################################################
  # Prepare yaml file for loading bam file into R
  path.load <- paste(path, 'load_bam', sep='/'); 
  if (!dir.exists(path.load)) dir.create(path.load);
  
  fn.bam <- paste(path, paste('pass', n, sep='_'), paste(nms, '_Aligned.sortedByCoord.out.bam', sep=''), sep='/');
  names(fn.bam) <- nms;
  
  fn <- sapply(names(fn.bam), function(nm) {
    pth <- paste(path.load, nm, sep='/');
    if (!file.exists(pth)) dir.create(pth, recursive = TRUE); 
    fn.r <- paste(pth, 'LoadBam.r', sep='/'); 
    fn.sh <- paste(pth, 'LoadBam.sh', sep='/'); 
    fn.yml <- paste(pth, 'LoadBam.yml', sep='/'); 
    
    y <- list(name=nm, output=path.load, bam=fn.bam[[nm]], exon=yaml$exon); 
    yml <- c(y, yaml$load); 
    
    # Write code
    lns <- c(paste('##', nm), 'require("GenomicRanges");', 'require("GenomicAlignments");', 'require("Rnaseq");', '');
    lns <- c(lns, paste('fn.yaml <- ("', fn.yml, '");', sep=''));
    lns <- c(lns, 'ct<-LoadBam(fn.yaml);', '');
    lns <- c(lns, paste('saveRDS(ct[[1]][[1]],', paste(pth, 'just_count.rds', sep='/'))); 

    writeLines(as.yaml(yml), fn.yml); 
    writeLines(paste(yaml$R, fn.r), fn.sh); 
    writeLines(lns, fn.r); 
    
    fn.sh;
  });

  writeLines(paste('sh', fn), paste(path.load, 'load_bam.sh', sep='/')); 
  writeLines(paste(yaml$qsub, fn), paste(path.load, 'qsub.sh', sep='/')); 
  
  # Combine read counts of all libraries
  fns.cnt <- paste(path.load, nms, 'just_count.rds', sep='/'); 
  names(fns.cnt) <- nms; 
  fn.cnt <- paste(path.load, 'file_count.rds', sep='/'); 
  saveRDS(fns.cnt, fn.cnt);

  fn.anno <- paste(path.load, 'anno.rds', sep='/'); 
  fn.map <- paste(path.load, 'exon2gene.rds', sep='/'); 
  
  # Lines to combined read counts
  lns <- c('require("Rnaseq");', 'require("GenomicRanges");', ''); 
  lns <- c(lns, paste('exon <- readRDS("', yaml$exon, '");', sep='')); 
  lns <- c(lns, paste('anno <- MapExon2Gene(exon, "transcript_id", "gene_id"); ')); 
  lns <- c(lns, paste('saveRDS(anno, "', fn.map, '");', sep='')); 
  lns <- c(lns, paste('saveRDS(anno$gene[, -(4:5)], "', fn.anno, '");', sep=''), ''); 
  lns <- c(lns, paste("ct <- Rnaseq::CombineCounts(readRDS('", fn.cnt, "'));", sep=''));
  lns <- c(lns, paste('saveRDS(ct, "', paste(paste(path.load, 'count_all.rds', sep='/')), '");', sep='')); 
  lns <- c(lns, paste('saveRDS(ct[[1]], "', paste(paste(path.load, 'count_gene.rds', sep='/')), '");', sep='')); 
  lns <- c(lns, 'c <- ct[[1]]; c <- log2(1+c[rowSums(c) > 0, , drop=FALSE]); '); 
  lns <- c(lns, paste('saveRDS(DEGandMore::NormLoess(c), "', paste(paste(path.load, 'normalized.rds', sep='/')), '");', sep='')); 
  lns <- c(lns, paste('sapply(names(ct), function(nm) saveRDS(ct[[nm]], paste("', path.load, '", "/count_", nm, ".rds", sep=""))) -> x;', sep=''));
  writeLines(lns, paste(path.load, 'count.r', sep='/')); 
  
  ############################################################################################################################################
  ############################################################################################################################################
  # Prepare yaml file for analyzing samples
  path.smpl <- paste(path, 'rnaseq_sample', sep='/'); 
  if (!dir.exists(path.smpl)) dir.create(path.smpl, recursive = TRUE);
  
  nm.cnt <- c('Unique_Paired_Sense'="unique", 'Multiple_Paired_Sense'="multiple", 'Unique_Unpaired_Sense'="unpaired_unique", 'Multiple_Unpaired_Sense'="unpaired_multiple", 
              'Unique_Paired_As'="unique_antisense", 'Multiple_Paired_As'="multiple_antisense", 'Unique_Unpaired_As'="unpaired_unique_antisense", 'Multiple_Unpaired_As'="unpaired_multiple_antisense");
  load.cnt <- rep(TRUE, length(nm.cnt)); 
  if (!yaml$load$paired) load.cnt[c(3,4,7,8)] <- FALSE;
  if (!yaml$load$antisense) load.cnt[5:8] <- FALSE;
  if (yaml$load$strand == 0) load.cnt[seq(2, 8, 2)] <- FALSE;
  nm.cnt <- nm.cnt[load.cnt]; 
  fn.cnt <- paste(path.load, paste('count_', nm.cnt, '.rds', sep=''), sep='/'); 
  names(fn.cnt) <- names(nm.cnt); 
  
  chr <- yaml$load$region;
  chrx <- yaml$load$female;
  chry <- yaml$load$male;
  chra <- setdiff(names(chr), c(chrx, chry)); 
  
  yaml2 <- list(
    template = "https://raw.githubusercontent.com/zhezhangsh/RoCA/master/template/qc/rnaseq_sample/rnaseq_sample.Rmd",
    output = paste(yaml$result, 'rnaseq_sample', sep='/'), home = yaml$home, analyst = yaml$analyst, zip = TRUE);
  yaml2$description <- yaml$description;
  yaml2$input <- list(count=as.list(fn.cnt), annotation=fn.anno, sample=yaml$sample);
  yaml2$parameter <- list(annotation=list(chromosome=1, length=2), chromosome=list(f=chrx, m=chry, autosome=chra)); 
  
  fn.smpl <- paste(path.smpl, 'rnaseq_sample.yaml', sep='/');
  writeLines(as.yaml(yaml2), fn.smpl);
  writeLines(paste('RoCA::CreateReport("', fn.smpl, '");', sep=''), paste(path.smpl, 'rnaseq_sample.r', sep='/'));
  writeLines(paste(yaml$R, paste(path.smpl, 'rnaseq_sample.r', sep='/')), paste(path.smpl, 'rnaseq_sample.sh', sep='/'))
  
  ########################################################################################################################
  ########################################################################################################################
  # Prepare yaml file for analyzing batch effect
  path.btch <- paste(path, 'adjust_batch', sep='/'); 
  if (!dir.exists(path.btch)) dir.create(path.btch, recursive = TRUE);

  yaml3 <- yaml2[1:6];
  yaml3$template <- 'https://raw.githubusercontent.com/zhezhangsh/RoCA/master/template/qc/adjust_batch/adjust_batch.Rmd';
  yaml3$output <- paste(yaml$result, 'adjust_batch', sep='/');
  yaml3$input <- list(matrix=paste(path.load, 'normalized.rds', sep='/'), sample=yaml$sample);
  yaml3$parameter <- yaml$batch;
  
  fn.btch <- paste(path.btch, 'adjust_batch.yaml', sep='/'); 
  writeLines(as.yaml(yaml3), fn.btch);
  writeLines(paste('RoCA::CreateReport("', fn.btch, '");', sep=''), paste(path.btch, 'adjust_batch.r', sep='/'));
  writeLines(paste(yaml$R, paste(path.btch, 'adjust_batch.r', sep='/')), paste(path.btch, 'adjust_batch.sh', sep='/'));
  
  ########################################################################################################################
  ########################################################################################################################
  # Prepare yaml file for analyzing outlier samples
  path.out <- paste(path, 'identify_outlier', sep='/'); 
  if (!dir.exists(path.out)) dir.create(path.out, recursive = TRUE);
  
  yaml4 <- yaml3[1:6];
  yaml4$template <- 'https://raw.githubusercontent.com/zhezhangsh/RoCA/master/template/qc/identify_outlier/identify_outlier.Rmd';
  yaml4$output <- paste(yaml$result, 'identify_outlier', sep='/');
  yaml4$input <- list(
    data = paste(path.load, 'normalized.rds', sep='/'), 
    annotation = paste(path.load, 'anno.rds', sep='/'),
    group = yaml$group,
    geneset = yaml$geneset
    );
  yaml4$parameter <- yaml$outlier;
  
  fn.out <- paste(path.out, 'identify_outlier.yaml', sep='/'); 
  writeLines(as.yaml(yaml4), fn.out);
  writeLines(paste('RoCA::CreateReport("', fn.out, '");', sep=''), paste(path.out, 'identify_outlier.r', sep='/'));
  writeLines(paste(yaml$R, paste(path.out, 'identify_outlier.r', sep='/')), paste(path.out, 'identify_outlier.sh', sep='/'));
  
}