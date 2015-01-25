library(datasets)

data <- JohnsonJohnson

# Declare values
df <- NULL
quarter <- NULL
lastQuarter <- NULL
startYear <- NULL
endYear <- NULL
stockPriceLog <- NULL
ownsStock <- NULL
numStocksOwned <- NULL
bank <- NULL
neutralStocksOwned <<- NULL
neutralBank <<- NULL
perfectStocksOwned <<- NULL
perfectBank <<- NULL
imperfectStocksOwned <<- NULL
imperfectBank <<- NULL
playState <- NULL
startAmount <- 1000000
shouldIncrement <- NULL
# Set values
setValues <- function() {
  df <<- as.data.frame(data)
  quarter <<- 0
  lastQuarter <<- dim(df)[1]
  startYear <<- 1960
  endYear <<- startYear + lastQuarter%/%4
  stockPriceLog <<- rep(NA,lastQuarter)
  currentStockPrice <<- df[1,]
  stocksOwned <<- 0
  bank <<- startAmount
  neutralStocksOwned <<- 0
  neutralBank <<- startAmount
  perfectStocksOwned <<- 0
  perfectBank <<- startAmount
  imperfectStocksOwned <<- 0
  imperfectBank <<- startAmount
  playState <<- FALSE
  shouldIncrement <<- TRUE
}
options(scipen=999)
# Start the values at their set values
setValues()

shinyServer(
  function(input, output, session) {
    
    drawData <- function() {
      output$plot <<- renderPlot({
        if(shouldIncrement) {
          quarter <<- quarter + 1 # Increment the quarter
          currentStockPrice <<- df[quarter,]
        }
        if(quarter == 1) {
          # Set up the first round of stock purchases
          neutralStocksOwned <<- neutralStocksOwned + neutralBank %/% currentStockPrice
          neutralBank <<- neutralBank - neutralStocksOwned * currentStockPrice
        }
        if(quarter < lastQuarter && currentStockPrice > df[quarter + 1,]) {
          # Stock Price has rised
          # Sell all stocks
          perfectBank <<- perfectBank + perfectStocksOwned * currentStockPrice
          perfectStocksOwned <<- 0
          # Imperfect Buys all stocks
          imperfectStocksOwned <<- imperfectStocksOwned + imperfectBank %/% currentStockPrice
          imperfectBank <<- imperfectBank - (imperfectBank %/% currentStockPrice * currentStockPrice)
        } else if(quarter < lastQuarter && currentStockPrice < df[quarter + 1,]) {
          # Stock price will rise
          # Buy as manys stocks as possible
          perfectStocksOwned <<- perfectStocksOwned + perfectBank %/% currentStockPrice
          perfectBank <<- perfectBank - (perfectBank %/% currentStockPrice * currentStockPrice)
          # Imperfect sells all stocks
          imperfectBank <<- imperfectBank + imperfectStocksOwned * currentStockPrice
          imperfectStocksOwned <<- 0
        }
        stockPriceLog[quarter] <<- currentStockPrice
        if(playState)
          if(quarter < lastQuarter) {
            shouldIncrement <<- TRUE
            invalidateLater(input$speedSlider, session)
          } else {
            # Game is over
            amountEarned <- bank + stocksOwned * currentStockPrice
            output$gameEndingOutput <- renderText({paste("Congratulations! You earned $", format(amountEarned, big.mark = ",", scientific = FALSE, nsmall = 2), "\nThat is a ", format(100 * (amountEarned - startAmount) / startAmount, nsmall = 2), "% change from the starting amount of $", format(startAmount, nsmall = 2))})
          }
        
        output$year <- renderText({paste("Year: ", startYear + quarter%/%4, "Q", (quarter-1)%%4+1, sep="")})
        output$stockprice <- renderText({paste("Stock Price: $", currentStockPrice, sep="")})
        output$stocksowned <- renderText({paste("Stocks Owned:", format(stocksOwned, big.mark = ",", scientific = FALSE, nsmall = 0), sep="")})
        
        # You
        output$valuation <- renderText({paste("Stock Value: $", format(stocksOwned * currentStockPrice, big.mark = ",", scientific = FALSE, nsmall = 2), sep="")})
        output$bank <- renderText({paste("Bank: $", format(bank, big.mark = ",", scientific = FALSE, nsmall = 2), sep="")})
        
        # Neutral
        output$neutralvaluation <- renderText({paste("Neutral Stock Value: $", format(neutralStocksOwned * currentStockPrice, big.mark = ",", scientific = FALSE, nsmall = 2), sep="")})
        output$neutralbank <- renderText({paste("Neutral Bank: $", format(neutralBank, big.mark = ",", scientific = FALSE, nsmall = 2), sep="")})
        
        # Perfect
        output$perfectvaluation <- renderText({paste("Perfect Stock Value: $", format(perfectStocksOwned * currentStockPrice, big.mark = ",", scientific = FALSE, nsmall = 2), sep="")})
        output$perfectbank <- renderText({paste("Perfect Bank: $", format(perfectBank, big.mark = ",", scientific = FALSE, nsmall = 2), sep="")})
        
        # Imperfect
        output$imperfectvaluation <- renderText({paste("Imperfect Stock Value: $", format(imperfectStocksOwned * currentStockPrice, big.mark = ",", scientific = FALSE, nsmall = 2), sep="")})
        output$imperfectbank <- renderText({paste("Imperfect Bank: $", format(imperfectBank, big.mark = ",", scientific = FALSE, nsmall = 2), sep="")})
        
        plot(seq(startYear, endYear-.25, .25), stockPriceLog, ylab = "Stock Price", xlab = "Year", type="l", ylim = c(0, max(df)))
      })
    }
    
    # Start off with the first data drawn
    drawData()
    
    observe({
      # Don't do anything if the button has never been pressed
      if (input$playGame == 0)
        return()
      
      isolate({
        playState <<- TRUE
        shouldIncrement <<- TRUE
        drawData()
      })
    })
    
    observe({
      # Don't do anything if the button has never been pressed
      if (input$resetGame == 0)
        return()
      
      isolate({
        # Reset all values
        setValues()
        # Redraw the starting plot
        shouldIncrement <<- FALSE
        output$gameEndingOutput <- renderText({""})
        drawData()
      })
    })
    
    observe({
      # Don't do anything if the button has never been pressed
      if (input$pauseGame == 0)
        return()
      
      isolate({
        playState <<- FALSE
        shouldIncrement <<- FALSE
        drawData()
      })
    })
    
    observe({
      # Don't do anything if the button has never been pressed
      if (input$buyStock == 0)
        return()
      
      isolate({
        # Buys as many stocks as possible
        stocksOwned <<- stocksOwned + bank %/% currentStockPrice
        bank <<- bank - (bank %/% currentStockPrice * currentStockPrice)
        shouldIncrement <<- FALSE
        drawData()
      })
    })
    
    observe({
      # Don't do anything if the button has never been pressed
      if (input$sellStock == 0)
        return()
      
      isolate({
        # Sells all stocks
        bank <<- bank + (stocksOwned * currentStockPrice)
        stocksOwned <<- 0
        shouldIncrement <<- FALSE
        drawData()
      })
    })
    
  }
)