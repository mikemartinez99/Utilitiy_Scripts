#!/bin/bash

#----- Quick helper script to make paired-end sample sheet that can be easily edited

#----- Set directory containing fastq.gz files
FASTQ_DIR="."  # or change to your directory, e.g., ./fastqs
OUTPUT_CSV="samples.csv"
LAYOUT="paired"

if [[ "$LAYOUT" == "paired" ]]; then
	#----- Generate header
	echo "fastq_1,fastq_2" > "$OUTPUT_CSV"
	
	#----- Loop over all R1 files and find matching R2
	for r1 in "$FASTQ_DIR"/*_R1*.fastq.gz; do
		#----- Skip if not match 
		[ -e "$r1" ] || continue
		
		#----- Derive R2 filename with sed
		r2="${r1/_R1/_R2}"	
		
		#----- Check that the R2 file exists
		if [[ -f "$r2" ]]; then
			echo "$r1,$r2" >> "$OUTPUT_CSV"
		else
			echo "Warning, No R2 file found for $r1" >&2
		fi
	done
else
	#----- Generate header
	echo "fastq_1" > "$OUTPUT_CSV"
	
	for f in "$FASTQ_DIR"/*.fastq.gz; do
  		[ -e "$f" ] && echo "$f" >> "$OUTPUT_CSV"
	done
fi
	



#----- Echo statement
echo "CSV written to $OUTPUT_CSV"
