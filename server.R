library(shiny)

shinyServer(function(input, output) {
  source("functions.R")
  
  ####Producing arbitrarily many widgets####
  
  #Create the button to turn the widgets on and off
  output$OnButton = renderUI({radioButtons("TurnOn", label="On/Off", choices=c("On"=1,"Off"=2), selected=2)})
  
  #Create the input to choose the number of widgets
  output$NumberOfWidgets=renderUI({numericInput("WidgetCount", label="How many widgets?", value=1)})
  
  #Define a reactive object to hold the list of widgets
  WidgetVector=reactive({lapply(X = 1:input$WidgetCount, FUN = EZmakeRadioButton)})
  
  #Create the output object to display the widgets
  output$WidgetVectorDisplay <- renderUI({
    if(is.null(input$TurnOn)){return()
    } else if(input$TurnOn == 2){return()
    } else tagList(WidgetVector()) })
  
  ####Producing a radio grid####
  
  #Create inputs to choose the number of rows and columns
  output$NumberOfRows=renderUI({numericInput("RowCount", label="How many rows?", value=1)})
  output$NumberOfColumns=renderUI({numericInput("ColumnCount", label="How many columns?", value=1)})
  
  #define a reactive object to hold the radio grid
  WidgetGrid = reactive({
    if(is.null(input$RowCount) | is.null(input$ColumnCount)){return()
    } else makeRadioGrid(input$ColumnCount, InLine = TRUE, label = 1:input$RowCount , droplabels = TRUE) })
  
  #create the output object to display the grid
  output$RadioGrid = renderUI({
    if(is.null(input$RowCount) | is.null(input$ColumnCount)){return()
    } else tagList(WidgetGrid()) })
  
  ####Producing a scrollable radio grid####
  
  #Create inputs to choose the number of rows and columns
  output$NumberOfRows2=renderUI({numericInput("RowCount2", label="How many rows?", value=9)})
  output$NumberOfColumns2=renderUI({numericInput("ColumnCount2", label="How many columns?", value=5)})
  
  #create output objects to select whether to do inline or not, and whether to apply relative position to CSS
  output$InlineChooser = renderUI(radioButtons(inputId = "InRows", 
                                               label = "Put in rows?", 
                                               choices = list("yes" = TRUE, "no" = FALSE), 
                                               selected = FALSE) )
  output$PositionChooser = renderUI(radioButtons(inputId = "Position", 
                                                 label = "Apply position:relative to CSS?", 
                                                 choices = list("yes" = TRUE, "no" = FALSE), 
                                                 selected = FALSE) )
  
  #create a variable to hold the value of style tag for the sidebarPanel  
  positionstyle = reactive({
    if(is.null(input$Position)){return()
    } else if(input$Position){"overflow-y:scroll; max-height: 600px; position:relative;"
    } else {"overflow-y:scroll; max-height: 600px"} })
  
  #define a reactive object to hold the radio grid
  WidgetGrid2 = reactive({
    if(is.null(input$RowCount2) | is.null(input$ColumnCount2)){return()
    } else makeRadioGrid(input$ColumnCount2, InLine = input$InRows, label = paste0("a",1:input$RowCount2)) })
  
  #create the output object to hold the grid
  output$RadioGrid2partial = renderUI({
    if(is.null(input$RowCount2) | is.null(input$ColumnCount2)){return("")
    } else tagList(WidgetGrid2()) })
  
  #create the output object to display the sidebarPanel with the grid in it
  output$RadioGrid2 = renderUI({sidebarPanel(
    style = positionstyle(),
    uiOutput("RadioGrid2partial")) }) 
  
  ####Defining a radio grid and extracting the info####
  
  #Create inputs to choose the number of rows and columns, and reactive variables to name them
  output$NumberOfRows3=renderUI({numericInput("RowCount3", label="How many rows?", value=9)})
  output$NumberOfColumns3=renderUI({numericInput("ColumnCount3", label="How many columns?", value=5)})
  NamesOfRows = reactive(paste0("Extractable",LETTERS[1:input$RowCount3]))
  NamesOfColumns = reactive(paste0("Selection ",letters[1:input$ColumnCount3]))
  
  #define a reactive object to hold the radio grid
  WidgetGrid3 = reactive({
    if(is.null(input$RowCount3) | is.null(input$ColumnCount3)){return()
    } else return(makeRadioGrid(input$ColumnCount3, InLine = TRUE, label = NamesOfRows())) })
  
  #create the output object to display the grid
  output$RadioGrid3 = renderUI({
    if(is.null(input$RowCount3) | is.null(input$ColumnCount3)){return("")
    } else tagList(WidgetGrid3()) })
  
  #create an output object to display the summary
  output$summary = renderUI({
    if(is.null(input$RowCount3) | is.null(input$ColumnCount3)){return()
    } else tagList(SummaryStuff()) }) 
  
  #define a reactive object to hold the various summary info
  SummaryStuff = reactive(
    if(is.null(input$RowCount3) | is.null(input$ColumnCount3)){return()
    } else makeSummary(columns = NamesOfColumns(), rows = NamesOfRows(), input) )
})