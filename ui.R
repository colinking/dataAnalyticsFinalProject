#install.packages('devtools')
#devtools::install_github('shiny-incubator', 'rstudio')
library(shinyIncubator)

shinyUI(
  pageWithSidebar(
    headerPanel("Stock Market Simulator"),
    sidebarPanel(
      h4("Simulator Controls"),
      actionButton('playGame', 'Play Simulator', icon = icon("play")),
      br(),br(),
      actionButton('resetGame', 'Reset Simulator', icon = icon("repeat")),
      br(),br(),
      actionButton('pauseGame', 'Pause Simulator', icon = icon("pause")),
      br(),br(),
      actionButton('buyStock', 'Buy Stock', icon = icon("money")),
      br(),br(),
      actionButton('sellStock', 'Sell Stock', icon = icon("trash-o")),
      br(),br(),
      sliderInput("speedSlider", "Change How Quickly Time Passes", 20, 5000, value = 1000),
      textOutput("gameEndingOutput")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Docs",
                 h4("Introduction"),
                 p("Welcome to the Stock Market Simulator!"),
                 p("Did I say simulator? I meant real life, of course!
                   Your grandfather has just passed away and left behind a 
                   generous sum of money in your name. It's up to you to 
                   carry out the family name and become a billionaire from 
                   the stock market! (well, you can try at least)"),
                 br(),
                 br(),
                 h4("How to Invest"),
                 p("Over on the \"Simulator\" tab, you can track the stock prices over time and track how much money you currently have both in stocks and in the bank. You start with $1,000,000 and can choose to buy stocks by clicking the \"Buy Stock\" button which will convert everything in your bank into stocks, based on the current market price. If you feel like the market price is about to drop, sell those stocks! You can do this with the \"Sell Stocks\" button up on the left. Feel free to use your supernatural powers to influence the passage of time by changing the slider on the left. The number on the slider is the number of milliseconds between each market quarter. If time is going too quickly, feel free to click the \"Pause Simulator\" button to stop time. When you're ready, click the \"Play Simulator\" button to start. "),
                 br(),
                 br(),
                 h4("Explanation of Simulator Value"),
                 p(strong("Year"), ": The current year and quarter"),
                 p(strong("Stock Price"), ": The current price of stock on the market"),
                 p(strong("Stock Owned"), ": The number of stocks that you currently own"),
                 p(strong("Stock Value"), ": The total value of all the stocks that you currently own (current stock price * stocks owned)"),
                 p(strong("Bank"), ": The amount of money you own that is not in stocks"),
                 p(strong("Neutral Bank"), ": The Neutral Stock Value and Bank measures how much money you could have made if you bought all the stock you could right at the beginning and then never traded again"),
                 p(strong("Perfect Bank"), ": The Perfect Stock Value and Bank measures how much money you could have made if you traded at the perfect time, every time as in you sold every time the stock price was about to drop and bought every time the stock was about to rise"),
                 p(strong("Imperfect Bank"), ": The Imperfect Stock Value and Bank measures how much money you could have made if you traded at the worst possible times, every time, as in you bought stock everytime the stock price was about to drop and sold stock everytime the stock price was about to rise"),
                 br(),
                 br(),
                 p("This simulator was created by Colin King for the 
                   Developing Data Products Class by Johns Hopkins University")
        ),
        tabPanel("Simulator", 
                 plotOutput("plot"),
                 textOutput("year"),
                 textOutput("stockprice"),
                 br(),
                 textOutput("stocksowned"),
                 textOutput("valuation"),
                 textOutput("bank"),
                 br(),
                 textOutput("neutralvaluation"),
                 textOutput("neutralbank"),
                 br(),
                 textOutput("perfectvaluation"),
                 textOutput("perfectbank"),
                 br(),
                 textOutput("imperfectvaluation"),
                 textOutput("imperfectbank"),
                 br(),
                 br(),
                 br(),
                 br()
        )
      )
      
    )
  )
)