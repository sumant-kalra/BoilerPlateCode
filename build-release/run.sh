#!/usr/bin/env bash

#SBATCH --job-name=appSK

#SBATCH --ntasks=N
#SBATCH --cpus-per-task=K
#SBATCH --mem-per-cpu=Qg
#SBATCH --ntasks-per-node=R
#SBATCH --exclusive   

#SBATCH --partition=partitionName
#SBATCH --output=outputs/result-%j.out       
#SBATCH --error=outputs/result-%j.err
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=sumant.kalra@hpe.com
#SBATCH --time=10:00:00

module load <module1_RequiredForApp>
module load <module2_RequiredForApp>
module load <moduleN_RequiredForApp>

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

srun app [appArg1] [appArg2] ...  [appArgN]

# 1. Test the script without sbatch 
# 2. Submit to slurm (if successful) with: sbatch run.sh 


# References:
# https://slurm.schedmd.com/sbatch.html
# https://slurm.schedmd.com/documentation.html
# https://slurm.schedmd.com/man_index.html
