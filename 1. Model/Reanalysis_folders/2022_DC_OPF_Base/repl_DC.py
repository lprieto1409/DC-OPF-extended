#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat May  4 11:23:57 2024

@author: lprieto
"""


for year in range(1950,2023):
    folder = f'/share/infews/lprieto/Paper_2_DC_OPF/Reanalysis_folders/{year}_DC_OPF_Base'

    # Reemplazos
    string_old_1 = "folder_inputs = '/Volumes/ElSoldeCusco/1. Research/18. 2nd paper/8. Github/M2S_extended/1. Model/Model_inputs/'"
     
    string_new_1 = "folder_inputs = '/share/infews/lprieto/Paper_2_DC_OPF/Model_inputs/'"

    string_old_2 = "folder_network = '/Volumes/ElSoldeCusco/1. Research/18. 2nd paper/8. Github/M2S_extended/1. Model/Network_inputs/'"

    string_new_2 = "folder_network = '/share/infews/lprieto/Paper_2_DC_OPF/Network_inputs/'"

    string_old_3 = "f'/Volumes/ElSoldeCusco/1. Research/18. 2nd paper/8. Github/M2S_extended/1. Model/Reanalysis_folders/{year}_DC_OPF_Base'"

    string_new_3 = "f'/share/infews/lprieto/Paper_2_DC_OPF/Reanalysis_folders/{year}_DC_OPF_Base'"
    
    string_old_4 = "folder = '/Volumes/ElSoldeCusco/1. Research/18. 2nd paper/8. Github/M2S_extended/1. Model/'"

    string_new_4 = " "


    with open(folder + f"wrapper_{year}.py") as f:
        content = f.read()

    new_content = content.replace(string_old_1, string_new_1)
    new_content = new_content.replace(string_old_2, string_new_2)
    new_content = new_content.replace(string_old_3, string_new_3)

    with open(folder + f"wrapper_{year}.py", "w") as f:
        f.write(new_content)

    

