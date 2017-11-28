#1
load("C:/Users/leo/Desktop/git1/R/final/lvr_prices_big5.RData")
#2
str(lvr_prices)
#3.
head(lvr_prices,10)
#4.
lvr_prices[lvr_prices$total_price > 0,]
install.packages('dplyr')
library(dplyr)
filter(lvr_prices, city_land_type == '住' & total_price > 0 & building_sqmeter > 0 &  finish_ymd != "")
house <- filter(lvr_prices, city_land_type == '住' & total_price > 0 & building_sqmeter > 0 &  finish_ymd != "")
house
save(house,file='C:/Users/leo/Desktop/git1/houses.RData')

#5.
house$price_per_sqmeter=round(house$total_price/house$building_sqmeter,0)
load("C:/Users/leo/Desktop/git1/houses.RData")
#7.
install.packages('ggplot2')
library('ggplot2')
summary(house$area)
g <- ggplot(house,aes(x=area))
g <-g+geom_bar()
g<-g+geom_bar(fill='purple',color='black')
g<-g+xlab('行政區')+ylab('筆數')
g
#8.barchart
請使用house資料，計算各行政區每平方米價格(price_per_sqmeter)欄位資料的平均數，中位數及標準差 [8分]
house %>%
  group_by(area) %>%
  summarise(mean(price_per_sqmeter),median(price_per_sqmeter),sqrt(var(price_per_sqmeter)))


#(9) 請使用house資料,利用ggplot2的facet_wrap函數繪製各行政區房屋每平方米價格(price_per_sqmeter)的直方圖 [8分]
f<-ggplot(house,aes(x=price_per_sqmeter))
f+geom_histogram()+facet_wrap(~area)

#(10) 

house$building_age = as.integer(round((Sys.Date()-as.Date(house$finish_ymd))/365,0))

#(11)
load("c:/Users/leo/Desktop/git1/R/final/house_danger.RData")

house<-merge(house, house_danger, by.x ='Unnamed..0', by.y ='ID', all.x = TRUE)

#(12)
install.packages("C50")
library(C50)


set.seed(1206)
#把資料分成training data 和 testing data
ind<-sample(1:2, size=nrow(house), replace=T, prob=c(0.8, 0.2))
trainset=house[ind==1,]
testset=house[ind==2,]

(13)
house.rp <- rpart(churn ~., data=trainset)
plot(house.rp, margin=0.1)
text(house.rp, all=TRUE, use.n=TRUE)
