#ui.R

library(shiny)

shinyUI(fluidPage(
  titlePanel("WidgetVector"),
  mainPanel(
    width = 12,
    tabsetPanel(
      tabPanel(title = "Set # of Widgets",
               uiOutput("OnButton"),
               uiOutput("NumberOfWidgets"),
               uiOutput("WidgetVectorDisplay") ),
      tabPanel(title = "Radio grid",
               fluidRow(
                 column(width = 6, uiOutput("NumberOfRows")),
                 column(width = 6, uiOutput("NumberOfColumns")) ),
               fluidRow(
                 column(width = 12, uiOutput("RadioGrid")) ) )
    )#end of tabsetPanel
  )#end of mainPanel
))#end of shinyUI