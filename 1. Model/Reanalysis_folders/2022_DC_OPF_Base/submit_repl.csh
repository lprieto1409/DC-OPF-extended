#!/bin/tcsh
#BSUB -J Remplazandooo
#BSUB -n 16
#BSUB -R "span[hosts=1]"
#BSUB -W 5000
#BSUB -o out.%J
#BSUB -e err.%J

# activate environment
conda activate /usr/local/usrapps/infews/group_env
module load gurobi

# Running the code
#python Avg_wind_speed.py
python repl_DC.py

conda deactivate
