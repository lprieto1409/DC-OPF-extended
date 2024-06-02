#!/bin/tcsh
#BSUB -J my_jo
#BSUB -n 16
#BSUB -R "span[hosts=1]"
#BSUB -W 5000
#BSUB -o out.%J
#BSUB -e err.%J

# activate environment
conda activate /usr/local/usrapps/infews/group_env
module load gurobi

# Submit multiple jobs at once
set folNameBase = Base

foreach year (`seq 1940 2022`)
    # Directory name
    set dirName = ${year}_DC_OPF_${folNameBase}
    if (-d $dirName) then
        cd $dirName
    else
        echo "Directory $dirName does not exist"
        exit 1
    endif

    # Error handling
    set python_script1 = "MTSDataSetup_${year}.py"
    set python_script2 = "wrapper_${year}.py"
    
    if (! -e $python_script1 || ! -e $python_script2) then
        echo "One or both Python scripts do not exist"
        exit 1
    endif
    
    # Run scripts
    python3 $python_script1
    if ($status == 0) then
        echo "MTSDataSetup_${year}.py ran successfully"
        python3 $python_script2
        if ($status != 0) then
            echo "wrapper_${year}.py did not run successfully"
        endif
    else
        echo "MTSDataSetup_${year}.py did not run successfully"
    endif
    cd ..
end

conda deactivate
