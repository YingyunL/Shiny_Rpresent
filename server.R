library(shiny)
library(stats)

shinyServer(
  function(input, output) {
    fit <- reactive({
        model <- input$model
        mdata=subset(Orange, Tree %in% model)
        fit1 <- lm(circumference ~ age, mdata)
    })
 
    output$plot1 <- renderPlot({
      model <- input$model
      mdata=subset(Orange, Tree %in% model)
      plot(mdata$age, mdata$circumference, xlab="Tree age, days", ylab="Tree Trunk Circumference, mm", main="Orange Tree Growth Prediction Parameter Fitting" )
      params <- coef(fit())
      param_names <- names(params)
      abline(fit(), col="blue", lwd=2)
      legend("right", legend=rbind(param_names, round(params,5)), bty="n")
    })
    
    # redirect input data
    output$otree <- renderPrint({input$model})
    output$osize <- renderPrint({input$size})
    output$osdate <- renderPrint({input$startdate})
    output$ocdate <- renderPrint({input$checkdate})
    
    otargetdate <- reactive({
        params <- coef(fit())
        b0=params[1] # intercept
        b1=params[2] # slope
        days <- floor((input$size-b0)/b1)
        targetdate <- input$startdate + days
    })

    otargetsize <- reactive({
        params <- coef(fit())
        b0=params[1] # intercept
        b1=params[2] # slope
        numberOfDays <- as.integer(input$checkdate - input$startdate)
        targetsize <- round((b0 + b1*numberOfDays), 5)
    })

    output$otdate <- renderText({as.character(otargetdate())})
    output$otsize <- renderText({otargetsize()})

  }
)
