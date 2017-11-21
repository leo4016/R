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

#(10) 試利用房屋完工日期(finish_ymd)產生一新變數為屋齡(building_age)加入house資料中。
#hint1: 取得當前日期的函數為 Sys.Date()
#hint2: 一年請以365天計算，四捨五入至整數位
#hint3: 將運算完的資料轉為整數型態(integer) [8分]


house$house_age = house$finish_ymd-Sys.Date()


