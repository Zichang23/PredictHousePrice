# load pacakages
library(forecast)
library(tseries)

# read in data
house<- get(load(file="House.RData"))

# overview of data
head(house)
knitr::kable(house[,1:6], caption = "Overview of House Price Dataset")

# change dataset to long format
house2 <- t(house[,-1])
colnames(house2) <- c("Dallas","CPI", "Interest")
house2 <- data.frame(Month=rownames(house2), house2)
rownames(house2) <- NULL
house2$Month <- ymd(house2$Month)
knitr::kable(house2[1:6,], caption = "Overview of House Price Dataset")

# time series plot
tsplot(house2[,1], house2[,2], xlab="Month", ylab="House Price", main="Dallas House Price", cex=0.1)

# create time series data
house3 <- ts(house2[,2], start=c(2013,1), end = c(2023,3), frequency = 12)

# check variance before transformation
round(sd(house3[1:(n/2)]))
round(sd(house3[(n/2):n]))

# Box-Cox transformation
n = length(house3)
boxcox.l = BoxCox.lambda(house3)
house3.transformed = (house3^(boxcox.l) - 1)/log(house3)

# check variance after transformation
round(sd(house3.transformed[ (1:floor(n/2))]),4)
round(sd(house3.transformed[-(1:floor(n/2))]),4)

# plot histogram
hist(house3, xlab = "Price",main = "Original Series")
hist(house3.transformed, xlab = "Price (Transformed)",main = "Transformed Series")

# ACF plot and PACF plot
house4 <- house3.transformed
par(mfrow=c(2,1))
acf1(house4, main="ACF Plot")
acf1(house4, pacf = T, main="PACF Plot")

# fit structural regression model
str.reg = decompose(house4)
plot(str.reg)

# seasonal period s
s = length(str.reg$figure)

# trend differencing the time series(d=1)
yt = diff(house4, lag=1, differences = 1)

# Dickey-Fuller test
adf.test(yt)

# seasonal differencing the time series (D=1)
zt = diff(yt, lag=s)

# ACF and PACF plots after differencing
par(mfrow=c(2,1))
acf1(zt, max.lag = 50)
acf1(zt, max.lag = 50, pacf=TRUE)

# fit seasonal ARIMA(1,1,2)x(0,0,0)_12 model
sarima.fit = sarima(house4, 1, 1, 2, 0, 1, 1, s, xreg=c(house2$Interest))

# fit multiple linear model
fit  = lm(house2$Dallas ~ house2$Month+house2$CPI+ house2$Interest, na.action=NULL)
summary(fit)

# five-step ahead forecast
House_price_transformed <- house4
sarima.for(House_price_transformed, n.ahead = 5, p=1,d=1,q=2,P=0,D=1,Q=1,S=12)

