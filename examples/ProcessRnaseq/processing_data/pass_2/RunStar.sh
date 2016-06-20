############
# ND410-B
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND410-B_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND410-B_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND410-B_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND410-B_Aligned.sortedByCoord.out.bam



############
# ND410-M
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND410-M_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND410-M_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND410-M_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND410-M_Aligned.sortedByCoord.out.bam



############
# ND410-T
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND410-T_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND410-T_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND410-T_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND410-T_Aligned.sortedByCoord.out.bam



############
# ND422-B
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND422-B_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND422-B_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND422-B_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND422-B_Aligned.sortedByCoord.out.bam



############
# ND422-M
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND422-M_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND422-M_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND422-M_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND422-M_Aligned.sortedByCoord.out.bam



############
# ND422-T
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND422-T_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND422-T_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND422-T_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND422-T_Aligned.sortedByCoord.out.bam



############
# ND426-B
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1603011/ND426-B4_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1603011/ND426-B4_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND426-B_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND426-B_Aligned.sortedByCoord.out.bam



############
# ND430-M
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND430-M_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/ND430-M_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND430-M_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND430-M_Aligned.sortedByCoord.out.bam



############
# ND426-T
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1603011/ND426-T2_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1603011/ND426-T2_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND426-T_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/ND426-T_Aligned.sortedByCoord.out.bam



############
# SLE1077-B
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1077-B_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1077-B_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1077-B_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1077-B_Aligned.sortedByCoord.out.bam



############
# SLE1077-M
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1077-M_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1077-M_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1077-M_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1077-M_Aligned.sortedByCoord.out.bam



############
# SLE1077-T
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1077-T_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1077-T_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1077-T_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1077-T_Aligned.sortedByCoord.out.bam



############
# SLE1169-B
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1169-B_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1169-B_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1169-B_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1169-B_Aligned.sortedByCoord.out.bam



############
# SLE1169-M
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1169-M_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1169-M_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1169-M_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1169-M_Aligned.sortedByCoord.out.bam



############
# SLE1169-T
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1169-T_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE1169-T_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1169-T_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE1169-T_Aligned.sortedByCoord.out.bam



############
# SLE985-B
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE985-B_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE985-B_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE985-B_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE985-B_Aligned.sortedByCoord.out.bam



############
# SLE985-M
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE985-M_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE985-M_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE985-M_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE985-M_Aligned.sortedByCoord.out.bam



############
# SLE985-T
/mnt/isilon/cbmi/variome/rnaseq_workspace/tools/STAR-STAR_2.4.1c/bin/Linux_x86_64_static/STAR \
--readFilesIn /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE985-T_1.fq.gz /mnt/isilon/cbmi/variome/BGI/CPF1505009/SLE985-T_2.fq.gz \
--genomeDir /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/star \
--sjdbGTFfile /mnt/isilon/cbmi/variome/rnaseq_workspace/refs/hg38/genes.gtf \
--runThreadN 8 \
--readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
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
--outFileNamePrefix /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE985-T_ \
--sjdbFileChrStartEnd /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_1/combined_SJ.out.tab

/mnt/isilon/cbmi/variome/bin/Samtools/samtools-1.2/samtools index /home/zhangz/R/source/Rnaseq/examples/ProcessRnaseq/./processing_data/pass_2/SLE985-T_Aligned.sortedByCoord.out.bam



