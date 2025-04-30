#!/usr/bin/env bash

#-----------------------------------------------------------------------------------------------#
# The purpose of this script is to parse through the multiQC bowtie2.txt output to determine
# mitochondrial reads (after running DAC RNA-Seq Pipeline)
#
# Author: Mike Martinez
#
# Inputs: Path to bowtie2.txt file (multiQC folder)
# Output: Mitochondrial reads
#-----------------------------------------------------------------------------------------------#


#----- Define variables
WORKINGDIR="/dartfs-hpc/rc/lab/G/GMBSR_bioinfo/Labs/whitfield/241008_RNAseq/multiqc_data"
BOWTIEFILE="multiqc_bowtie2.txt"
IDXFILE="mqc_samtools-idxstats-mapped-reads-plot_Raw_Counts.txt"

#----- Move to the working directory
cd "$WORKINGDIR"

#----- Extract sample name and total reads from the bowtie file
awk '{print $1, $2}' "$BOWTIEFILE" > total_reads.txt

#----- Find the column number for 'chrM'
chrM_col=$(head -1 "$IDXFILE" | tr '\t' '\n' | grep -n "^chrM$" | cut -d: -f1)

#----- Check if chrM column was found
if [[ -z "$chrM_col" ]]; then
    echo "chrM column not found in $IDXFILE"
    exit 1
fi

#----- Extract sample name and mitochondrial reads (chrM column) with a header
awk -v col="$chrM_col" 'BEGIN {print "Sample_Name", "Mitochondrial_Reads"} NR>1 {print $1, $(col)}' "$IDXFILE" > mito_reads.txt

if [[ ! -f total_reads.txt || ! -f mito_reads.txt ]]; then
    echo "One or both input files do not exist."
    exit 1
fi

#----- Concatenate the files into one table
paste total_reads.txt mito_reads.txt | awk '{print $1, $2, $4}' > mt_summary.txt 
awk 'NR==1 {print $0; next} {if ($2 > 0) percent = ($3 / $2) * 100; else percent = 0; print $0, percent}' mt_summary.txt > mt_summary_with_percent.txt

