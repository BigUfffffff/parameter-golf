#!/bin/bash -l
#SBATCH --partition=cip
#SBATCH --output=soft-routing-test-files/soft_routing_phase2_%j.out
#SBATCH --gres=gpu:a40:1
#SBATCH --time=00:30:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=2

source .venv/bin/activate

nvidia-smi

export ITERATIONS=500
export VAL_LOSS_EVERY=250
#export MAX_WALLCLOCK_SECONDS=600
export TOKENIZER_PATH="/scratch/s/S.Basten/parameter-golf/data/tokenizers/fineweb_1024_bpe.model"
export DATA_PATH="/scratch/s/S.Basten/parameter-golf/data/datasets/fineweb10B_sp1024"

python train_gpt.py