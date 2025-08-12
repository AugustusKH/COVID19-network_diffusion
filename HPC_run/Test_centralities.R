#!/usr/bin/env R

setwd("/data/users/c3671ur/test")

library(igraph)
# n = number of nodes, m = the number of edges
erdos.gr <- sample_gnm(n=10, m=25) 

#plot(erdos.gr)
degree.cent <- centr_degree(erdos.gr, mode = "all")
closeness.cent <- closeness(erdos.gr, mode="all")

df<- cbind.data.frame(degree = degree.cent$res, closeness = closeness.cent)
write.csv(df, paste0(getwd(), '/Centralities.csv'), row.names = T)
