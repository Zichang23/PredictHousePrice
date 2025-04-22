# Time Series Analysis of Dallas House Prices

### 1. Introduction

This project examines Dallas housing market fluctuations over a decade (2013-2023), identifying key price drivers and forecasting future trends.

#### 1.1 Data

Data was collected from three sources: Zillow.com [Dallas monthly house prices](https://www.zillow.com/research/data/), Federal Reserve Bank of St. Louis [CPI](https://fred.stlouisfed.org/series/MORTGAGE30U), and OECD [monthly interest rates](https://stats.oecd.org/index.aspx?queryid=86#). The dataset contains 123 observations spanning January 2013 to March 2023, with three variables: Dallas monthly house prices, CPI, and monthly interest rates.

#### 1.2 Research Questions

a. What are the trends and seasonal patterns in Dallas housing prices over time?

b. Which time series model is appropriate for fitting the housing prices data?

c. Which factors have a significant influence on housing prices over time?

d. What are the predictions for future changes in housing prices?

### 2. Statistical Analysis

#### 2.1 ACF Plot and PACF Plot

The ACF plot (below) shows gradual tailing off with many significant lags, while the PACF plot cuts off after lag 1, suggesting an AR(1) model is appropriate for this data.

#### 2.2 Data Transformation

Initial analysis revealed non-constant variance with standard deviations of 28558 and 41171 for the first and second halves of the dataset, respectively. After applying a Box-Cox transformation, standard deviations became 0.0360 and 0.0327, satisfying the constant variance assumption.

The histogram below demonstrates that applying the Box-Cox method resulted in modest improvements to the data's normality distribution.

#### 2.3 Structural Regression Model

Figure below reveals an increasing trend with distinct 12-month seasonality and some residual seasonal patterns in the random component, indicating need for a model addressing both trend and seasonality.

<img src="docs/1.png" width="500" />

#### 2.4 Model Building

Dickey-Fuller testing ($H_0: | \phi| = 1; H_1: |\phi| < 1)$ yielded $p$ = 0.01 after first differencing ($d = 1$), confirming stationarity. Figure 5 shows gradually decaying ACF, PACF cutting off after lag 2, and pseudo-sinusoidal ACF patterns suggesting residual seasonality.

#### 2.5 Multiple Linear Regression

#### 2.6 Forecasting

### 3. Conclusion

#### 3.1 Summary for Dataset and Data Analysis

#### 3.2 Comments for Research Questions
