#!/usr/bin/env bash

#SBATCH --job-name=downsample
#SBATCH --nodes=1
#SBATCH --partition=preempt1
#SBATCH --account=dac
#SBATCH --time=60:00:00
#SBATCH --mail-user=f007qps@dartmouth.edu
#SBATCH --mail-type=FAIL
#SBATCH --output=downsample_%j.out

#----- START
echo -e "#-----------------------------------------------------------#"
echo "Starting job: $SLURM_JOB_NAME (Job ID: $SLURM_JOB_ID)"
echo "Running on node: $(hostname)"
echo "Start time: $(date)"
echo -e "#-----------------------------------------------------------#"

#----- Activate conda environment
source /optnfs/common/miniconda3/etc/profile.d/conda.sh
conda activate /dartfs-hpc/rc/lab/G/GMBSR_bioinfo/misc/owen/sharedconda/miniconda/envs/seqtk_env

#----- Specify input directory and output directory
INPUT="/dartfs-hpc/rc/lab/G/GSR_Active/Labs/Curiel/RNASeq-GMBSR-250220/downsample"
OUTPUT="/dartfs-hpc/rc/lab/G/GSR_Active/Labs/Curiel/RNASeq-GMBSR-250220/downsample/downsampled"
cd "$INPUT"

#----- Begin the downsampling
seqtk sample -s 42 175660-17_S17_R1_001.fastq.gz 0.38 | gzip > "$OUTPUT/175660-17_S17_R1_001.fastq.gz"
seqtk sample -s 42 175660-18_S18_R1_001.fastq.gz 0.47 | gzip > "$OUTPUT/175660-18_S18_R1_001.fastq.gz"
seqtk sample -s 42 175660-19_S19_R1_001.fastq.gz 0.41 | gzip > "$OUTPUT/175660-19_S19_R1_001.fastq.gz"
seqtk sample -s 42 175660-20_S20_R1_001.fastq.gz 0.41 | gzip > "$OUTPUT/175660-20_S20_R1_001.fastq.gz"
seqtk sample -s 42 175660-21_S21_R1_001.fastq.gz 0.49 | gzip > "$OUTPUT/175660-21_S21_R1_001.fastq.gz"
seqtk sample -s 42 175660-22_S22_R1_001.fastq.gz 0.54 | gzip > "$OUTPUT/175660-22_S22_R1_001.fastq.gz"
seqtk sample -s 42 175660-23_S23_R1_001.fastq.gz 0.43 | gzip > "$OUTPUT/175660-23_S23_R1_001.fastq.gz"


echo "Downsampling completed."
echo "End time: $(date)"

