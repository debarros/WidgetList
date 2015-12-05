#functions.R

#Define a simple function that creates radioButton objects
EZmakeRadioButton = function(n){radioButtons(
  inputId = paste0("EZRadio",n),
  label="Pick one",
  choices=1:3,
  selected=1)}

#Define a function that creates radioButton objects
makeRadioButton = function(inline = FALSE, opts = 3, label = NULL, inputid = "Radio"){
  choices = as.list(1:opts)
  names(choices) = rep(x = " ", times = opts) 
  radioButtons(inputId = inputid,label=label,choices=choices,selected=1, inline = inline)}

#Define a function that creates the radio grid
makeRadioGrid = function(columns = 2, InLine = FALSE, label = "Select", droplabels = FALSE){
  rows = length(label)
  x = list()
  if(droplabels){for (i in 1:rows){x[[i]] = makeRadioButton(inline = InLine, opts = columns, label = NULL, inputid = label[i])}
  } else for (i in 1:rows){x[[i]] = makeRadioButton(inline = InLine, opts = columns, label = label[i], inputid = label[i])}
  return(x)}

#Define a function to summarize what has been selected
makeSummary = function(columns, rows, input){   
  columnTotals = data.frame(Column = columns, Count = as.integer(rep(x = NA, times = length(columns)))) 
  for (i in 1:length(columns)){columnTotals$Count[i] = sum(mgetReactive(input, rows) == i)}
  return(renderTable(expr = columnTotals))}

#Define a function that uses characters strings as inputIds, and returns their values
mgetReactive = function(reactiveObject, components){
  x = list()
  for (i in components){x[[i]] = reactiveObject[[i]]}
  return(x)}