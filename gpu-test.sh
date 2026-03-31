#!/bin/bash -l
#SBATCH --partition=cip
#SBATCH --output=gpu1.sh.%j.out
#SBATCH --gres=gpu

# show selected GPU
nvidia-smi