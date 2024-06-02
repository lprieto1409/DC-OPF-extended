#!/bin/tcsh
#BSUB -J DC_OPF_run
#BSUB -n 16
#BSUB -R "span[hosts=1]"
#BSUB -W 5000
#BSUB -o out.%J
#BSUB -e err.%J

# Activate environment
conda activate /usr/local/usrapps/infews/group_env
module load gurobi

# Main folder containing year folders
set main_folder = "/share/infews/lprieto/Paper_2_DC_OPF/Reanalysis_folders"

# Iterate through years
foreach year (`seq 1940 2022`)
    set folder_name = ${year}_DC_OPF_Base
    set python_script1 = "MTSDataSetup_${year}.py"
    set python_script2 = "wrapper_${year}.py"
    set full_folder_path = "${main_folder}/${folder_name}"

    # Check if the folder exists
    if (-d $full_folder_path) then
        cd $full_folder_path

        # Check if both Python scripts exist
        if (-e $python_script1 && -e $python_script2) then
            # Run scripts
            python $python_script1
            if ($status == 0) then
                echo "${python_script1} ran successfully"
                python $python_script2
            else
                echo "${python_script1} did not run successfully"
            endif
        else
            echo "One or both Python scripts do not exist for year ${year}"
        endif

        # Go back to the main folder
        cd $main_folder
    else
        echo "Folder ${full_folder_path} does not exist"
    endif
end

# Deactivate environment
conda deactivate

