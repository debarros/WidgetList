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
               fluidRow(column(width = 12, uiOutput("RadioGrid")) ) ),
      tabPanel(title = "Scrollable grid",
               sidebarLayout(
                 uiOutput("RadioGrid2"),
                 mainPanel(
                   fluidRow(
                     column(width = 6, uiOutput("NumberOfRows2")),
                     column(width = 6, uiOutput("NumberOfColumns2")) ),
                   fluidRow(uiOutput("InlineChooser")),
                   fluidRow(uiOutput("PositionChooser")) ) ) ),#end of tabPanel
      tabPanel(title = "Extract from grid",
               sidebarLayout(
                 sidebarPanel(
                   style = "overflow-y:scroll; max-height: 600px; position:relative;",
                   uiOutput("RadioGrid3")),
                 mainPanel(
                   fluidRow(
                     column(width = 6, uiOutput("NumberOfRows3")),
                     column(width = 6, uiOutput("NumberOfColumns3")) ),
                   fluidRow(uiOutput("summary"))
                 )#end of mainPanel
               )#end of sidebarLayout
      )#end of tabPanel
    )#end of tabsetPanel
  )#end of mainPanel
))#end of shinyUI