View(Sales)
library(moments)
library(ggplot2)
library(dplyr)
counts <- Sales %>%
  count(`Region`)
counts <- Sales %>%
  count(`Profit`)
East = subset(Sales, Region =="East")
Eastprofit = East %>% group_by(Month) %>% 
  summarise(max_profit= max(Profit), min_profit=min(Profit), avg_profit = 
              mean(Profit))
Eastprofit_s <- Eastprofit %>% mutate(Region = "East")
South = subset(Sales, Region =="South")
Southprofit = South %>% group_by(Month) %>% 
  summarise(max_profit= max(Profit), min_profit=min(Profit), avg_profit = 
              mean(Profit))
Southprofit_s <- Southprofit %>% mutate(Region = "South")
West = subset(Sales, Region =="West")
Westprofit = West %>% group_by(Month) %>% 
  summarise(max_profit= max(Profit), min_profit=min(Profit), avg_profit = 
              mean(Profit))
Westprofit_s <- Westprofit %>% mutate(Region = "West")
North = subset(Sales, Region =="North")
Northprofit = North %>% group_by(Month) %>% 
  summarise(max_profit= max(Profit), min_profit=min(Profit), avg_profit = 
              mean(Profit))
Northprofit_s <- Northprofit %>% mutate(Region = "North")
combined_data <- bind_rows(Eastprofit_s, Southprofit_s, Westprofit_s, Northprofit_s)
monthlabels=c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
combined_data$Month <- factor(combined_data$Month, levels = monthlabels)
ggplot(combined_data, aes(x = Month, y = avg_profit, color = Region, 
                          group = Region)) +
  geom_line(size = 1.5) +
  geom_point(size = 3) + # Adding points to mark data points
  labs(x = "Months", y = "Average Profit ($)",
       title = "Average profit by Month and Region") +
  theme_minimal()
