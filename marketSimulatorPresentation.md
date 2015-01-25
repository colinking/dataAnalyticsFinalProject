Stock Market Simulator
========================================================
author: Colin King
date: Jan. 25, 2015

Introduction
========================================================

Investing in the stock market and making money while doing it is a very difficult task. This simulator strives to give the user a feel for trading in the stock market. This simulator allows users to buy and sell stock and compare how they are doing to the perfect, imperfect and neutral cases.

Dataset
========================================================

In this simulator, the Johnson and Johnson dataset of stock prices from 1960-1980 was used. Here is an example of what the first year of stock prices look like:

```
[1] 0.71 0.63 0.85 0.44
```
Each data point is the price of one share for each quarter during 1960.

Comparisons
========================================================

Within the simulator, the user can see how the money they raised compares to the perfect, imperfect and neutral cases. All of these cases are buying and selling the same stock, but they do it at certain times.
- <small>**Perfect**: In this case, the stock is traded at the best possible times: stock is always sold before the market price would drop and stock is always bought right before the market price would rise. This case represents the maximum possible earnings.</small>
- <small>**Imperfect**: In this case, the stock is traded at the worst possible times: stock is always bought before the market price would drop and stock is always sold right before the market price would rise. This case represents the minimum possible earnings.</small>
- <small>**Neutral**: In this case, stock is bought during the starting quarter, but never traded again. This represents how much the user could earn if they put their starting money into the market and never traded again.</small>

Try it out
==========================

The Simulator is available here: https://colinking.shinyapps.io/MarketSimulatorDataAnalytics/

Check out the documentation tab to learn how to use the simulator and check out the Simulator tab to see it in action.
