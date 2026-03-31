#!/bin/bash -l
#SBATCH --partition=cip
#SBATCH --output=baseline_%j.out
#SBATCH --gres=gpu:a40:1
#SBATCH --time=00:10:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=2

# Activate the virtual environment
source ../.venv/bin/activate

# Show selected GPU information
nvidia-smi

# Set environment variables for the training script
export ITERATIONS=100
#export MAX_WALLCLOCK_SECONDS=600.0
export TOKENIZER_PATH="/scratch/s/S.Basten/parameter-golf/data/tokenizers/fineweb_1024_bpe.model"
export DATA_PATH="/scratch/s/S.Basten/parameter-golf/data/datasets/fineweb10B_sp1024"

# Run the training script
python ../train_gpt.py