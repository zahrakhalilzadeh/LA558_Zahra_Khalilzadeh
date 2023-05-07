install.packages("ggplot2")
library(ggplot2)
data3Month=read.csv("C:/Users/zahra/Documents/Spring2023/CRP558-WebMapping/FinalProject
                    /2018IOWAMarchMidMay.csv")

data<-data.frame(Yield=data3Month$yield, Precipitation=data3Month$PrecipitationLevels, 
                 SolarRadiation=data3Month$SolarRadiationLevels, 
                 AverageTemperature=data3Month$AvergaeTemperatureLevels)
str(data)
data$Precipitation=as.factor(data$Precipitation)
data$SolarRadiation=as.factor(data$SolarRadiation)
data$AverageTemperature=as.factor(data$AverageTemperature)

Anova<-lm(Yield~SolarRadiation*Precipitation*AverageTemperature, data = data)
summary(Anova)
boxplot(Yield~SolarRadiation,data=data)
ggplot(data, 
       aes(x = Precipitation, y = Yield,colour = SolarRadiation)) + 
  geom_boxplot() + facet_wrap( ~ AverageTemperature, scales="free")


