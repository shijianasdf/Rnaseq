############
# SLE1169-T
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1169-T_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1169-T_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype SAM \
--chimSegmentMin 32 \
--outFilterType BySJout \
--outFilterMultimapNmax 20 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outFilterMismatchNmax 999 \
--outFilterMismatchNoverLmax 0.04 \
--alignIntronMin 20 \
--alignIntronMax 1000000 \
--alignMatesGapMax 1000000 \
c("--junction TRUE", "--junction combined_SJ.out.tab", "--junction FALSE", "--junction TRUE", "--junction list(read = 3, overhang = 5, sample = 2, total = 10)") \
--twopassMode None \
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/SLE1169-T_


