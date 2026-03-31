#!/bin/bash -l
#SBATCH --partition=cip
#SBATCH --output=soft-routing-test-files/soft_routing_baseline_%A_%a.out
#SBATCH --gres=gpu:a40-24gb:1
#SBATCH --time=02:00:00
#SBATCH --mem=8G
#SBATCH --cpus-per-task=2
#SBATCH --array=1-10

source .venv/bin/activate

nvidia-smi

export WANDB_API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
export WANDB_MODE=online

export ITERATIONS=700
export VAL_LOSS_EVERY=250
export MAX_WALLCLOCK_SECONDS=6000
export TOKENIZER_PATH="/scratch/s/S.Basten/parameter-golf/data/tokenizers/fineweb_1024_bpe.model"
export DATA_PATH="/scratch/s/S.Basten/parameter-golf/data/datasets/fineweb10B_sp1024"

python -u train_gpt_baseline_vs.py