library(shiny)
 
shinyUI(pageWithSidebar(
  headerPanel("Orange Tree Growth Predicator"),

  sidebarPanel(
    h2('Input'),
    h3('Model tree selection'),
    numericInput('model', 'Select one of the trees as the model', 1, min = 1, max = 5, step = 1),
    submitButton('Submit'),
    h4('Select a date when an orange tree was or will be planted'),
    dateInput("startdate", "Planting Date:", "1970-1-1"),
    h4('Select a date to check the size of the planted tree'),
    dateInput("checkdate", "Checking Date:", "2015-1-1"),
    h4('Select a desired trunk circumferences (mm) of the planted tree'),
    numericInput('size', 'Trunk Circumferences (mm) Desired', 500),
    submitButton('Submit')
  ),
  
  mainPanel(

    h2('Instructions:'),
    p('This application uses the "Orange" data frame from the R "datasets" package. Growth data from five trees are available from the data frame. A user first selects one of the five trees as a model for predication. A linear growth rate will be obtained for that tree by fitting the data to a linear model. A graph will be shown about the regression.'),
    p('In the next section, a user can select a planting date and an end date, the application will calculate the tree circumference on the end date according to the growth rate obtained from the previous section, and output to the webpage.'),
    p('Alternatively, a user can select a planting date and the desired circumference, the application will calculate the date when the planted tree will reach that size using the rate obtained from the first section.'),

    h2('Results'),

    h3('Build Model from Selected Tree'),
    h4('The tree you selected for model building:'), verbatimTextOutput("otree"),
    plotOutput('plot1'),

    h4('The planting date for the tree being predicted, you entered:'),
    verbatimTextOutput("osdate"),

    h4('For the date you want to check the size of this tree, You entered:'),
    verbatimTextOutput("ocdate"),
    h4('On this date, the predicted circumference in mm for the trunk of the tree is:'),
    verbatimTextOutput("otsize"),

    h4('For the target trunk circumference (mm) of the tree, you entered:'),    
    verbatimTextOutput("osize"),
    h4('The predicted date for this tree to reach this size:'),    
    verbatimTextOutput("otdate")
    
  )
))
