#!/bin/bash -l
#SBATCH --job-name=data_prep
#SBATCH --output=prep_%j.out
#SBATCH --partition=cip        
#SBATCH --time=02:00:00           
#SBATCH --mem=32G                 

export HF_HOME="/scratch/s/S.Basten/.cache/huggingface"
mkdir -p $HF_HOME



source ../.venv/bin/activate
python ../data/cached_challenge_fineweb.py --variant sp1024       