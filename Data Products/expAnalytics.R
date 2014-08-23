#load the libraries
library (shiny)
library (shinyapps)
library (ggplot2)

# function to plot the graph, given the category
#   and the angle for the x-axis labels
plotData = function (category, xlabAngle = 0) {
  
  # drop the unused factor levels
  tmpDf = droplevels (subset (expDf, Category == category))
  
  # plot the data
  ggplot(data=tmpDf, 
         aes(x=CategoryValue, y=ExpenseValue, group = ExpenseType,
             color = ExpenseType)) + 
    geom_line() + geom_point() +
    labs (title = 
            paste0 ("Expenditure by ", category)) +
    scale_x_discrete (category) +
    scale_y_continuous ("Expenditure in $") +
    theme (axis.text.x = element_text (angle = xlabAngle))
  
}

# function to calculate the national averages, given the user's
#   demographics
getExpenses = function (ageGroup, income, region, race) {
  
  # find the corresponding set of national averages
  tmpDf = subset (expDf,
                  (Category == "Age group" & CategoryValue == ageGroup) |
                    (Category == "Income before taxes" & CategoryValue == income) |
                    (Category == "Region of residence" & CategoryValue == region) |
                    (Category == "Race" & CategoryValue == race),
                  select = c (ExpenseType, ExpenseValue)
  )
  
  # calculate the average
  df = aggregate (. ~ ExpenseType, tmpDf, 
                  function (x) c (mean = round (mean(x))))  
  return (df)
  
}

# function to create a summary dataframe with the user's data Vs the national averages
summaryDf = function (ageGroup = "24 & Under",
                      income = "$00 - 05 K",
                      region = "Mid West",
                      race = "African American",
                      food = 0,
                      housing = 0,
                      utilities = 0,
                      transportation = 0,
                      healthcare = 0,
                      entertainment = 0,
                      misc = 0) {
  
  # calculate total annual expenditure
  annualExp = food + housing + utilities + transportation + healthcare +
    entertainment + misc
  
  # get the national averages for the user's demographics
  natAvgDf = getExpenses (ageGroup, income, region, race)
  natAvgDf$Type = "U.S. National Average"
  
  # gather user's data into a dataframe
  myDf = data.frame (Type = c ("You"),
                     ExpenseType = expTypes,
                     ExpenseValue =  c (food, housing, utilities, transportation,
                                        healthcare, entertainment, misc,
                                        annualExp))
  
  
  # create a combined dataframe, for ease of plotting
  combDf = rbind (natAvgDf, myDf)
  
  return (combDf)
}

# function to plot the user's data Vs the national averages
summaryPlot = function (ageGroup = "24 & Under",
                        income = "$00 - 05 K",
                        region = "Mid West",
                        race = "African American",
                        food = 0,
                        housing = 0,
                        utilities = 0,
                        transportation = 0,
                        healthcare = 0,
                        entertainment = 0,
                        misc = 0) {
  
  # create a combined dataframe with user's data Vs national avg
  combDf = summaryDf (ageGroup, income, region, race,
                      food, housing, utilities, transportation,
                      healthcare, entertainment, misc)
  
  # plot the data
  plotObj = ggplot(data=combDf, 
                   aes(x=ExpenseType, y=ExpenseValue, group = Type,
                       fill = Type)) + 
    geom_bar (stat="identity",
              position=position_dodge(), size=.1) +
    labs (title = 
            "Your household annual expenditure Vs U.S. national average") +
    scale_x_discrete ("Expense Type") +
    scale_y_continuous ("Expenditure in $") +
    theme (axis.text.x = element_text (angle = 90)) 
  
  return (plotObj)
}

# function to create summary of the user's data Vs the national averages
summaryText = function (ageGroup = "24 & Under",
                        income = "$00 - 05 K",
                        region = "Mid West",
                        race = "African American",
                        food = 0,
                        housing = 0,
                        utilities = 0,
                        transportation = 0,
                        healthcare = 0,
                        entertainment = 0,
                        misc = 0) {
  
  # create a combined dataframe with user's data Vs national avg
  # right now this is calculated twice, for the summary plot and the text
  # change it later to store in a globally accessible dataframe
  combDf = summaryDf (ageGroup, income, region, race,
                      food, housing, utilities, transportation,
                      healthcare, entertainment, misc)
  
  natAvgAnnualExp = combDf [combDf$ExpenseType == "Annual Total" &
                              combDf$Type == "U.S. National Average"  , "ExpenseValue"]
  avgAnnualExp = combDf [combDf$ExpenseType == "Annual Total" &
                           combDf$Type == "You"  , "ExpenseValue"]
  
  # calculate difference, if the user's total expenditure > 0
  if (avgAnnualExp > 0) {
    
    diffAmt = round (avgAnnualExp - natAvgAnnualExp)
    diffPct = round (diffAmt/natAvgAnnualExp * 100)
    
    underOver = ifelse (diffAmt < 0, "below", "above")
    
    # set summaryTxt
    textObj = paste0 ("Your household annual expenditure ($", avgAnnualExp, ")",
                      " is $", abs (diffAmt),
                      " (", abs (diffPct), "%) ",
                      underOver, " the national average ($", natAvgAnnualExp, ")")
    
  } else {
    textObj = ""
  }
  
  return (textObj)
}


## main

# read the csv file containing the national averages
expDf = read.csv ("Expense Summary Normalized.csv")

# set the different expenditure categories
expTypes = c ("Food", "Housing", "Utilities", "Transportation", "Healthcare",
              "Entertainment", "Misc", "Annual Total")

# load the document html file
docuFile = 'ExpAppDocumentation.html'
docuText = readChar(docuFile, file.info (docuFile)$size)

# plot the data using the function
ageGroupPlot = plotData ("Age group")
incomePlot = plotData ("Income before taxes", 90)
regionPlot = plotData ("Region of residence")
racePlot = plotData ("Race")
