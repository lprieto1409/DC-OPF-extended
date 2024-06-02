#!/bin/tcsh
#BSUB -J DC_OPF_run
#BSUB -n 16
#BSUB -R "span[hosts=1]"
#BSUB -W 5000
#BSUB -o out.%J
#BSUB -e err.%J

# activate environment
conda activate /usr/local/usrapps/infews/group_env
module load gurobi

# Error handling
set python_script1 = "MTSDataSetup.py"
set python_script2 = "wrapper.py"
if (! -e $python_script1 || ! -e $python_script2) then
    echo "One or both Python scripts do not exist"
    exit 1
endif

# Run scripts
python $python_script1
if ($status == 0) then
    echo "MTSDataSetup.py ran successfully"
    python $python_script2
else
    echo "MTSDataSetup.py did not run successfully"
endif

conda deactivate
