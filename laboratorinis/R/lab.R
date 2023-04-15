library(readr)
lab_sodra <- read_csv("laboratorinis/data/lab_sodra.csv")

summary(lab_sodra)


lab_sodra
#1 uzduotis 
library(tidyverse) 

filtered_data = lab_sodra %>%
  filter(ecoActCode == 702200)
filtered_data %>%
  ggplot(aes(x=avgWage)) +
  geom_histogram(colour = "white", fill = "black" )+
  theme_dark() +
  labs(title = "The average wage of employees")

#2 uzduotis 


top_5 = filtered_data %>%
  group_by(name) %>% 
  summarize(avg_salary = mean(avgWage))

top_5_companies = top_5 %>%
  arrange(desc(avg_salary)) %>%
  head(5)

#atrenka duomenis tu 5 kompaniju 

filtered_data2 = filtered_data %>%
  filter(name %in% top_5_companies$name)
filtered_data2

filtered_data2 %>%
  ggplot(aes(x = month, y = avgWage, color = name )) + 
  theme_minimal()+
  geom_line(size = 1) +
  labs(title = "Average salary of the top five companies") 
#3 uzduotis               

filtered_data2 %>% 
  group_by(name) %>% 
  slice_max(numInsured, with_ties = FALSE) %>%
  ggplot(aes(x = reorder(name, -numInsured), y = numInsured), color = name) +
  geom_col(aes(fill = name)) +
  labs(title = "Number of insured employees", x = "Company", y = "count")



