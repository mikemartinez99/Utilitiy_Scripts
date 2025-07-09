#!/bin/bash

#SBATCH --job-name=nanopack
#SBATCH --nodes=1
#SBATCH --partition=preempt1
#SBATCH --account=dac
#SBATCH --time=60:00:00
#SBATCH --mail-user=f007qps@dartmouth.edu
#SBATCH --mail-type=FAIL
#SBATCH --output=nanopack_%j.out

#----- START
echo -e "#-----------------------------------------------------------#\n"
echo "Starting job: $SLURM_JOB_NAME (Job ID: $SLURM_JOB_ID)"
echo "Running on node: $(hostname)"
echo "Start time: $(date)"
echo -e "#-----------------------------------------------------------#\n"

#----- Source Conda
source /dartfs-hpc/rc/lab/G/GMBSR_bioinfo/misc/owen/sharedconda/miniconda/etc/profile.d/conda.sh
conda activate nanopack

#----- Path to concatenated data
INPUT=""
TITLE=""
PREFIX=""

#----- Run nanopack on the fully merged AdiS2 + 10 (adaptive + HMW sequencing)
NanoPlot -t 16 \
        -o $dir/QC \
        -p $prefix \
        --tsv_stats \
        --N50 \
        -f png \
        --title $TITLE \
        --color mediumseagreen \
        --fastq $INPUT