#!/bin/bash

#----- Quick helper script to make paired-end sample sheet that can be easily edited

#----- Set directory containing fastq.gz files
FASTQ_DIR="."  # or change to your directory, e.g., ./fastqs
OUTPUT_CSV="samples.csv"

#----- Header
echo "fastq_1,fastq_2" > "$OUTPUT_CSV"

#----- Loop over all R1 files and find matching R2
for r1 in "$FASTQ_DIR"/*_R1*.fastq.gz; do
    #----- Skip if no match (in case glob fails)
    [ -e "$r1" ] || continue

    #----- Derive R2 filename
    r2="${r1/_R1/_R2}"

    #----- Check if R2 file exists
    if [[ -f "$r2" ]]; then
        echo "$r1,$r2" >> "$OUTPUT_CSV"
    else
        echo "Warning: No R2 found for $r1" >&2
    fi
done

#----- Echo statement
echo "CSV written to $OUTPUT_CSV"
