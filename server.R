library(shiny)

shinyServer(function(input, output) {
  
  ##########################################
  ####Producing arbitrarily many widgets####
  
  #Create the button to turn the widgets on and off
  output$OnButton = renderUI({
    radioButtons("TurnOn", label="On/Off", choices=c("On"=1,"Off"=2), selected=2)})
  
  #Create the input to choose the number of widgets
  output$NumberOfWidgets=renderUI({
    numericInput("WidgetCount", label="How many widgets?", value=1)})
  
  #Define a function that creates radio button objects
  makeRadioButton=function(n=1){
    radioButtons(paste0("Radio",n),label="Pick one",choices=c(1:3),selected=1)}
  
  #Define a reactive object to hold the list of widgets
  WidgetVector=reactive({
    lapply(X = 1:input$WidgetCount, FUN = makeRadioButton)})
  
  #Create the output object to display the widgets
  output$WidgetVectorDisplay <- renderUI({
    if(is.null(input$TurnOn)){return()
    } else if(input$TurnOn == 2){return()
    } else tagList(WidgetVector())})
  
  
  ##############################
  ####Producing a radio grid####
  
  #Create inputs to choose the number of rows and columns
  output$NumberOfRows=renderUI({
    numericInput("RowCount", label="How many rows?", value=1)})
  output$NumberOfColumns=renderUI({
    numericInput("ColumnCount", label="How many columns?", value=1)})
  
  #Define a function that creates rows of radio buttons
  makeRadioButton2 = function(n=1, inline = FALSE, opts = 3, label = NULL){
    choices = as.list(1:opts)
    names(choices) = rep(x = " ", times = opts) 
    radioButtons(paste0("Radio",n),label=label,choices=choices,selected=1, inline = inline)}
  
  #Define a function that creates the radio grid
  makeRadioGrid = function(rows = 2, columns = 2){
    lapply(X = 1:rows, FUN = makeRadioButton2, inline = TRUE, opts = columns)}
  
  #define a reactive object to hold the radio grid
  WidgetGrid = reactive({
    makeRadioGrid(input$RowCount, input$ColumnCount)})
  
  #create the output object to display the grid
  output$RadioGrid = renderUI({
    if(is.null(input$RowCount) | is.null(input$ColumnCount)){return()
    } else tagList(WidgetGrid())
  })
})