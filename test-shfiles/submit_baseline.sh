#!/bin/bash -l
#SBATCH --partition=cip
#SBATCH --output=baseline_%j.out
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00

# Set environment variables for the training script
export ITERATIONS=100
export MAX_WALLCLOCK_SECONDS=600.0

# Run the training script
python ../train_gpt.py