#!/usr/bin/env bash

#SBATCH --job-name=appSK

#SBATCH --ntasks=N
#SBATCH --cpus-per-task=K
#SBATCH --mem-per-cpu=Qg
#SBATCH --ntasks-per-node=R
#SBATCH --exclusive   

#SBATCH --partition=partitionName
#SBATCH --output=outputs/o-result-%j.out       
#SBATCH --error=outputs/e-result-%j.err
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=sumant.kalra@hpe.com
#SBATCH --time=10:00:00

source ./../modulesLoad.sh
./application  

# If the application uses OPENMP threads:
# export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

# Run the application here:
# srun app [appArg1] [appArg2] ...  [appArgN]

# 1. Test the script without sbatch 
# 2. Submit to slurm (if successful) with: sbatch run.sh 


# References:
# https://slurm.schedmd.com/sbatch.html
# https://slurm.schedmd.com/documentation.html
# https://slurm.schedmd.com/man_index.html
