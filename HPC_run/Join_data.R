#!/usr/bin/env R

setwd("/data/users/c3671ur/covid-19/permute_results")

library(dplyr)

#Import the original set
original_df <- read.table("Diffusion_original_scores.txt", header = TRUE)

#Import the permutation sets
set1_df <- read.table("Diffusion_permutation_scores1.txt", header=TRUE) %>% select(-c(symbol, original_value))
set2_df <- read.table("Diffusion_permutation_scores2.txt", header=TRUE) %>% select(-c(symbol, original_value))
set3_df <- read.table("Diffusion_permutation_scores3.txt", header=TRUE) %>% select(-c(symbol, original_value))
set4_df <- read.table("Diffusion_permutation_scores4.txt", header=TRUE) %>% select(-c(symbol, original_value))
set5_df <- read.table("Diffusion_permutation_scores5.txt", header=TRUE) %>% select(-c(symbol, original_value))
set6_df <- read.table("Diffusion_permutation_scores6.txt", header=TRUE) %>% select(-c(symbol, original_value))
set7_df <- read.table("Diffusion_permutation_scores7.txt", header=TRUE) %>% select(-c(symbol, original_value))

#Join data
join_dat_df <- original_df %>% inner_join(set1_df, by = c("nodes" = "nodes")) %>% inner_join(set2_df, by = c("nodes" = "nodes")) %>% inner_join(set3_df, by = c("nodes" = "nodes")) %>% inner_join(set4_df, by = c("nodes" = "nodes")) %>% inner_join(set5_df, by = c("nodes" = "nodes")) %>% inner_join(set6_df, by = c("nodes" = "nodes")) %>% inner_join(set7_df, by = c("nodes" = "nodes"))

#Save the data frame as a text file
write.table(join_dat_df, file = paste0(getwd(), "/join_dat_df.txt"), sep = "\t", quote = F, row.names = FALSE, col.names = TRUE)
