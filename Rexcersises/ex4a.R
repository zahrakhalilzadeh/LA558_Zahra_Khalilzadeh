#Zahra Khalilzadeh
#Excersise 4a
#LA 558, Spring 2023

# -----Excersixe4a----------

#Packages and libraries ####
library(ggplot2)


#Load the mtcars dataset by typing data(mtcars) ####
data(mtcars)

#Create a scatterplot of mpg vs. horsepower using ggplot() function ####
ggplot(mtcars, aes(x = hp, y = mpg)) + 
  geom_point()

#Create a barplot of the number of cylinders in each car model using ggplot() function.####
ggplot(mtcars, aes(x = factor(cyl))) + 
  geom_bar()
