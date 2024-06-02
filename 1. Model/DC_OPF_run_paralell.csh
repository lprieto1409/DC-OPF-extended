#!/bin/bash

#SBATCH -J DC_OPF_paralell
#SBATCH -n 16
#SBATCH --output=out.%j
#SBATCH --error=err.%j

# activate environment
source activate /usr/local/usrapps/infews/group_env
module load gurobi

# Submit multiple jobs at once
folNameBase="Base"

# Define a function to run for each year
run_year() {
    year=$1
    # Directory name
    dirName="${year}_DC_OPF_${folNameBase}"
    if [ -d "$dirName" ]; then
        cd $dirName
    else
        echo "Directory $dirName does not exist"
        return 1
    fi

    # Error handling
    python_script1="MTSDataSetup_${year}.py"
    python_script2="wrapper_${year}.py"
    
    if [ ! -e $python_script1 ] || [ ! -e $python_script2 ]; then
        echo "One or both Python scripts do not exist"
        return 1
    fi
    
    # Run scripts
    python3 $python_script1
    if [ $? -eq 0 ]; then
        echo "MTSDataSetup_${year}.py ran successfully"
        python3 $python_script2
        if [ $? -ne 0 ]; then
            echo "wrapper_${year}.py did not run successfully"
        fi
    else
        echo "MTSDataSetup_${year}.py did not run successfully"
    fi
    cd ..
}

export -f run_year

# Use GNU Parallel to run the function for each year
seq 1940 2022 | parallel -j 16 run_year

source deactivate
