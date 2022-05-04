#If you don't have any of these packages use it 
#install.packages("gganimate")
#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("gapminder")
#install.packages("ggthemes")
#install.packages("gifski")
#install.packages("av")
#install.packages("lubridate")


library(gganimate)
library(ggplot2)
library(dplyr)
library(gapminder)
library(ggthemes)
library(gifski)
library(av)
library(lubridate)

f_data <- read.csv("sequences.csv") #Read main data with read.csv() function

f_data_d <- f_data[order(as.Date(f_data$Release_Date, format="%Y-%m-%d")),] #Reorder the date data with year/month/day pattern
na.omit(f_data_d) #Eliminate NA values from data frame to prevent errors

f_data_d <- f_data_d[-which(f_data_d$Country == ""), ] #Eliminate the rows contain empty value for "Countries" column

f_data_r <- f_data_d %>% filter(grepl("2021", Release_Date)) #Eliminates the years other than 2021

months <- month(as.POSIXlt(f_data_r$Release_Date, format="%Y-%m-%d")) #Take the month values as a date 

months <- as.data.frame(months) #Convert data into data frame

f_data_merged <- cbind(months, f_data_r) #Merge the month data with old data frame 

#Filter the specific countries and re-group according to the their reps
f_spc_data <- f_data_merged %>% dplyr::mutate(MonthName = month.name[months]) %>% filter(Country == "USA" |
                                        Country == "United Kingdom" |
                                        Country == "Switzerland" |
                                        Country == "Germany") %>%
  group_by(Country, months) %>% 
  summarise(reps = n())

f_spc_data <- f_spc_data %>% dplyr::mutate(MonthName = month.name[months])

f_spc_data$MonthName <- factor(f_spc_data$MonthName, levels = c("January","February","March","April","May","June","July","August","September","October","November","December"))

#Data visualization stage starts
#Prepare bar plot with data that filtered before

new_plot <- f_spc_data %>% ggplot(aes(x = reps , y = Country, fill = Country)) + 
  geom_bar(stat = "identity") +
  theme_bw() #Prepare bar plot with data that filtered before
new_plot

#Convert the normal plot to animated one
#transition_time() argument should be a date, integer or smth like that
#Subtitle indicates that every change on frame time related to the date which variant released 
#Never stop the process until finished, rendering could be take some time (related to your system specs)

new_animation <- new_plot + transition_states(MonthName, transition_length = 2, state_length = 0) +
  labs(title = "Animated Visualisation of Variant Data COVID-19", 
       subtitle ='Month: {closest_state}')
new_animation

animate(new_animation, width = 600, height = 300, fps = 20)
#Add specific customization and finalize the gif 
vfinal_animation <- animate(new_animation, height = 500, width = 800, fps = 30, duration = 10,
        end_pause = 60, res = 100, renderer = gifski_renderer())

anim_save("covid-19_variant.gif", vfinal_animation) #Save the animated graph as a gif 


























  
  
  
  
  
  
  
  

  
