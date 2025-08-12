#!/usr/bin/env R

setwd("/data/users/c3671ur/covid-19")

library(igraph)
library(diffusr)
library(dplyr)
library(readr)

#Import Ensembl info
Ensembl_info <- read_table("9606.protein.info.v11.5.txt")

#Import an adjacency matrix from the text file
adj_mat_df <- read.table("df_from_matrix.txt", header = TRUE)
adj_mat <- as.matrix(adj_mat_df)

#import seed_nodes_df.txt to a vector
seed_nodes_df <- read.table("seed_nodes_df.txt", header  = TRUE)

#Construct the initial heat diffusion vector
h0 <- replicate(nrow(adj_mat), 0)
names(h0) <- rownames(adj_mat)
seed_nodes <- as.vector(seed_nodes_df$nodes)
h0[seed_nodes] <- 1/length(seed_nodes)

#Original heat diffusion algorithm
stable_heat_values <- heat.diffusion(h0, adj_mat, t = 0.5)

#Convert the result to a data frame
diffusion_df <- as.data.frame(stable_heat_values) %>%
  rename(original_value = V1) %>%
  mutate(nodes = rownames(adj_mat)) %>%
  inner_join(Ensembl_info, by = c("nodes" = "#string_protein_id")) %>%
  select(nodes, symbol = preferred_name, original_value)
  
#Save the data frame as a text file
write.table(diffusion_df, file = paste0(getwd(), "/Diffusion_original_scores.txt"), sep = "\t", quote = F, row.names = FALSE, col.names = TRUE)