# -*- coding: utf-8 -*-
"""
Created on Sun Aug  9 00:47:29 2023

@author: lprieto
"""

import pandas as pd
import numpy as np

folder_model = '/Volumes/ElSoldeCusco/1. Research/18. 2nd paper/8. Github/M2S_extended/1. Model/Model_inputs/'

# Read data_genparams_partial.csv into a DataFrame
df = pd.read_csv(folder_model + 'data_genparams_partial_corr.csv', header=0)

# Modify the 'node' column by appending 'n_' to each value
for i in range(len(df)):
    df.loc[i, 'node'] = 'n_' + str(df.loc[i, 'node'])

# Extract the 'name' column from the DataFrame
gens = df.loc[:, 'name']

# Read unique_nodes.csv into a DataFrame
all_nodes = pd.read_csv(folder_model + 'unique_nodes_corr.csv', header=0, index_col=0)
all_nodes.columns = ['Name']
all_nodes = list(all_nodes['Name'])

# Initialize df_A with the 'name' column from df as the index and columns as all_nodes
df_A = pd.DataFrame(index=df['name'], columns=all_nodes).fillna(0)

# Initialize a list to store missing nodes
missing = []

# Populate the df_A DataFrame based on the 'node' values in df
for i in range(len(gens)):
    node = df.loc[i, 'node']
    df_A.loc[gens[i], node] = 1

    if node not in all_nodes:
        missing.append(node)

# Save the resulting DataFrame df_A to a CSV file named 'gen_mat.csv'
df_A.to_csv(folder_model + 'gen_mat_corr.csv')



