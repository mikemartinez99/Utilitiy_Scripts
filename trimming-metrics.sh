#!/usr/bin/env bash

#-----------------------------------------------------------------------------------------------#
# The purpose of this script is to iterate through the cutadapt reports generated after running
# the DAC RNASeq Snakmake workflow. 
#
# Author: Mike Martinez
#
# Inputs: cutadapt log files
# Outputs: A 3 field file with sample name, number of bp processed, and number of bp passing filters
#-----------------------------------------------------------------------------------------------#

#----- Directory containing the cutadapt reports
TRIM_DIR="trimming"
cd "$TRIM_DIR"

#----- Output file
OUTPUT_FILE="cutadapt_summary.txt"

#----- Initialize output file with a header
echo -e "Sample\tTotal_Basepairs_Processed\tTotal_Basepairs_Written" > $OUTPUT_FILE

#----- Array of sample cutadapt report files to iterate over
REPORT_FILES=$(ls *.cutadapt.report)
echo "$REPORT_FILES"

#----- Iterate over each cutadapt.report file in the directory
for report in $REPORT_FILES; do
    
    #----- Extract sample name (filename prefix before "cutadapt.report")
    sample=$(basename "$report" | sed 's/\.cutadapt.report//')
    echo "$sample"

    #----- Extract the values for "Total basepairs processed" and "Total written (filtered)"
    total_processed=$(grep "Total basepairs processed" "$report" | awk '{print $4}' | sed 's/,//g')
    total_written=$(grep "Total written (filtered)" "$report" | awk '{print $4}' | sed 's/,//g')

    #----- Debugging: Print extracted values
    echo "Total Basepairs Processed: $total_processed"
    echo "Total Basepairs Written: $total_written"

    #----- Check if values are empty and handle errors
    if [[ -z "$total_processed" || -z "$total_written" ]]; then
        echo "Warning: Could not parse values for sample $sample in $report"
        continue
    fi

    #----- Output the sample name and corresponding values to the output file
    echo -e "$sample\t$total_processed\t$total_written" >> $OUTPUT_FILE
done

echo "Summary written to $OUTPUT_FILE"