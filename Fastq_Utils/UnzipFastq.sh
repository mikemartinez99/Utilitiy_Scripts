#!/bin/bash

#SBATCH --job-name=UnzipFastq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --partition=preempt1
#SBATCH --account=dac
#SBATCH --time=60:00:00
#SBATCH --mail-user=f007qps@dartmouth.edu
#SBATCH --mail-type=FAIL
#SBATCH --output=UnzipFastq_%j.out

#----- START
echo -e "#-----------------------------------------------------------#\n"
echo "Starting job: $SLURM_JOB_NAME (Job ID: $SLURM_JOB_ID)"
echo "Running on node: $(hostname)"
echo "Start time: $(date)"
echo -e "#-----------------------------------------------------------#\n"

#----- Activate conda environment (if any)
#source /optnfs/common/miniconda3/etc/profile.d/conda.sh
#conda activate /dartfs-hpc/rc/lab/G/GMBSR_bioinfo/misc/owen/sharedconda/miniconda/envs/seqtk_env

#----- SET INPUT AND OUTPUT
INPUT=""
OUTPUT=""

pigz -dk -p 8 -c "$INPUT" > "$OUTPUT"