# Expenditure analyzer UI

# fluidPage used for flexibility with layout
shinyUI (fluidPage(
  
  titlePanel ("Annual Expenditure Analyzer"),  
  sidebarLayout (  
    sidebarPanel (            
      selectInput ("ageGroup", "Age Group", 
                  choices = c ('24 & Under' = '24 & Under',
                              '25 - 34' = '25 - 34',
                              '35 - 44' = '35 - 44',
                              '45 - 54' = '45 - 54',
                              '55 - 64' = '55 - 64',
                              '65 & Over' = '65 & Over')),
      selectInput ("income", "Income Level", 
                  choices = c ('$00 - 05 K' = '$00 - 05 K',
                              '$05 - 09 K' = '$05 - 09 K',
                              '$10 - 15 K' = '$10 - 15 K',
                              '$15 - 20 K' = '$15 - 20 K',
                              '$20 - 30 K' = '$20 - 30 K',
                              '$30 - 40 K' = '$30 - 40 K',
                              '$50 - 60 K' = '$50 - 60 K',
                              'Over $70 K' = 'Over $70 K')),
      # fluidRow used for laying out input parameters side by side
      fluidRow (
        column(4,
      selectInput ("region", "Region", 
                  choices = c ('Mid West' = 'Mid West',
                              'North East' = 'North East',
                              'South' = 'South',
                              'West' = 'West'))),
      column(8,
      selectInput ("race", "Race", 
                  choices = c ('African American' = 'African American',
                              'Asian' = 'Asian',
                              'White & Others' = 'White & Others'
                  )))),
      fluidRow (
        column(4,
        numericInput ('food', 'Food Expenses', 0, min = 0, max = 100000)),
        column(8,
        numericInput ('housing', 'Housing Expenses', 0, min = 0, max = 100000))),
      fluidRow (
        column(4,
        numericInput ('utilities', 'Utilities', 0, min = 0, max = 100000)),
        column(8,
        numericInput ('transportation', 'Transportation', 0, min = 0, max = 100000))),
      fluidRow (
        column(4,
        numericInput ('healthcare', 'Healthcare', 0, min = 0, max = 100000)),
        column(8,
        numericInput ('entertainment', 'Entertainment', 0, min = 0, max = 100000))),
      fluidRow (
        column(4,
        numericInput ('misc', 'Misc Expenses', 0, min = 0, max = 100000))),
        submitButton ('Submit')
    ),
    
    mainPanel(
      #tabsetPanel used to display results on different tabs
      tabsetPanel(
        tabPanel ("Summary", textOutput ('summaryText'),
                  plotOutput ('summary'),
                  textOutput ('pageViews')
                  ), 
        tabPanel ("Age Group", plotOutput ('ageGroup')),
        tabPanel ("Income", plotOutput ('income')),
        tabPanel ("Region", plotOutput ('region')),
        tabPanel ("Race", plotOutput ('race')),
        tabPanel ("Documentation", uiOutput ('document')
                  )
      )
    )
  )
))