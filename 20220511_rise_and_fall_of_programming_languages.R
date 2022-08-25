# Project: Rise and Fall of Programming Languages

# Instructions

# Your questions are as follows:
  
# What fraction of the total number of questions asked in 2019 had the R tag? Save your answer as a variable r_percentage in percentage format (e.g. 0.5 becomes 50).
# What were the five most asked-about tags in the last 5 years (2015-2020)? Save your answer as a variable highest_tags in the form of character vector.

# Bonus: Rather than looking at the results in a table, you often want to create a visualization. Let's take a look at how the fraction of questions about the five most asked-about tags has evolved over the last five years (2015-2020). You'll want to show time on the x-axis and the fraction of questions asked that year on the y-axis, and a different color line for every tag. (This question will not be tested.)

# load packages

library(readr)
library(dplyr)
library(ggplot2)
library(scales)

# import dataset

data <- read_csv("datasets/stack_overflow_data.csv")

data

# Question 1

# filter for observations containing the tag "r"

r_tag_2019 <- data %>% filter(tag == 'r' , year == 2019 )
r_tag_2019

# calculate percentage
r_percec <- r_tag_2019 %>% mutate(r_perc = (number/year_total)*100)
r_percec

r_percentage <- round(as.numeric(r_percec$r_perc),2)
r_percentage

# Question 2

# filter time range, group by tag and arrange in descending order
top_five_1520 <- data %>% 
  filter(year >= 2015) %>%
  group_by(tag) %>%
  summarise(sum = sum(number)) %>%
  arrange(desc(sum))

# use head to see the top five
top_five_1520 <- head(top_five_1520,5)
top_five_1520

# store column 'tag' in a character vector
highest_tags <- top_five_1520[['tag']]
highest_tags

# visualise data

viz_data <- data %>%
  filter(year >= 2015, tag %in% highest_tags) %>%
  mutate(fraction = (number/year_total)*100)


viz1 <- ggplot(viz_data, aes(x = year, y = fraction)) + 
  geom_line(aes(color = tag))
viz1