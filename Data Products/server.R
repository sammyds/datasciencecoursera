# Expenditure analyzer server-side code

shinyServer (
  function (input, output) {
    
    # source the code expAnalytics.R that does the following
    # 1. loads the national average expenditure data from csv file
    # 2. prepares the static plots to be displayed
    # 3. computes the national averages for the user's demographics
    #    and plots the graphs
    # 4. loads the documentation from an html file
    
    source('expAnalytics.R')
    
    # Get number of page views. This code is not uploaded to github as it containts
    # database authentication information
    source('pageViews.R')
    
    # need to make this work later. right now it is called twice - for summary plot & text
#     combDf = reactive ({      
#               summaryDf (input$ageGroup, input$income, input$region, 
#                    input$race, input$food, input$housing, 
#                    input$utilities, input$transportation,
#                    input$healthcare, input$entertainment, 
#                    input$misc)
#             })
#       output$summary = renderPlot({      
#         summaryPlot (combDf)
#       })
# 
#       output$summaryText = renderText ({
#         summaryText (combDf)                            
#       })

    # render the plot to be displayed on the summary tab. this reactive
    #    plot gets refreshed when the input parameters are changed
    
    output$summary = renderPlot({      
                      summaryPlot (input$ageGroup, input$income, input$region, 
                        input$race, input$food, input$housing, 
                        input$utilities, input$transportation,
                        input$healthcare, input$entertainment, 
                        input$misc)
                    })

    output$summaryText = renderText ({
                          summaryText (input$ageGroup, input$income, input$region, 
                            input$race, input$food, input$housing, 
                            input$utilities, input$transportation,
                            input$healthcare, input$entertainment, 
                            input$misc)                            
                    })
    output$pageViews = renderText ({pageViews})
      
    # render the plot to be displayed in the age group tab
    output$ageGroup = renderPlot({
      ageGroupPlot
    })
    
    # render the plot to be displayed in the income tab
    output$income = renderPlot({
      incomePlot
    })
    
    # render the plot to be displayed in the region tab
    output$region = renderPlot({
      regionPlot
    })
    
    # render the plot to be displayed in the race tab
    output$race = renderPlot({
      racePlot
    })
    
    # show the documentation from the html file
    output$document = renderUI ({HTML(docuText)})
  }
)