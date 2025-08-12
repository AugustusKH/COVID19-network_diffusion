#!/usr/bin/env R

setwd("/data/users/c3671ur/covid-19/permute_results")

library(igraph)
library(diffusr)
library(dplyr)
library(readr)

#Import the original set
difffusion_set_df <- read.table("Diffusion_original_scores.txt", header = TRUE)

#Import an adjacency matrix from the text file
adj_mat_df <- read.table("df_from_matrix.txt", header = TRUE)
adj_mat <- as.matrix(adj_mat_df)

#import seed_nodes_df.txt to a vector
seed_nodes_df <- read.table("seed_nodes_df.txt", header  = TRUE)
seed_nodes <- as.vector(seed_nodes_df$nodes)

#Run permutation test (1-150)
set.seed(1)

for (i in 1:150){
  random_seed <- sample(rownames(adj_mat), length(seed_nodes))
  h0_permute <- replicate(nrow(adj_mat), 0)
  names(h0_permute) <- rownames(adj_mat)
  h0_permute[random_seed] <- 1/length(random_seed)
  stable_heat_values_permute <- heat.diffusion(h0_permute, adj_mat, t = 0.5)
  difffusion_set_df[ , ncol(difffusion_set_df) + 1] <- stable_heat_values_permute
  colnames(difffusion_set_df)[ncol(difffusion_set_df)] <- paste0("set_", i)
}
 
#Save the data frame as a text file
write.table(difffusion_set_df, file = paste0(getwd(), "/Diffusion_permutation_scores1.txt"), sep = "\t", quote = F, row.names = FALSE, col.names = TRUE)