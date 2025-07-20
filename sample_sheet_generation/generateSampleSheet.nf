#!/usr/bin/env nextflow

/*
 * Nextflow Pipeline to dynamically generate sample sheet with metadata linkage
 */

// Workflow parameters
params.layout = "paired"
params.inputDir = "/Users/mike/Desktop/Nextflow_Practice/dummy_data/"
params.outputFile = "sample_fastq_list.txt"

workflow {
    generateSampleSheet()
}

process generateSampleSheet {
    publishDir 'output', mode: 'copy'

    output:
    path "${params.outputFile}"

    script:
    def outputCsv = params.outputFile
    def inputDir = file(params.inputDir).toAbsolutePath() // ensure absolute path

    """
    OUTPUT_CSV="$outputCsv"

    if [[ "${params.layout}" == "paired" ]]; then
        echo "fastq_1,fastq_2" > "\$OUTPUT_CSV"

        for r1 in ${inputDir}/*_R1*.fastq.gz; do
            [ -e "\$r1" ] || continue
            r2="\${r1/_R1/_R2}"

            if [[ -f "\$r2" ]]; then
                echo "\$r1,\$r2" >> "\$OUTPUT_CSV"
            else
                echo "Warning: No R2 found for \$r1" >&2
            fi
        done
    elif [[ "${params.layout}" == "single" ]]; then
        echo "fastq_1" > "\$OUTPUT_CSV"

        for f in ${inputDir}/*.fastq.gz; do
            echo "\$f" >> "\$OUTPUT_CSV"
        done
    fi
    """
}

// To run this code: 
// run generateSampleSheet.nf --inputDir 'your_dir/' --layout 'paired'