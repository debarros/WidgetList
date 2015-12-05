# WidgetList
In R Shiny, create arbitrarily many widgets based on input

**Tabs**

The first tab in the app shows how to use an input to determine the number of `radioButton` widgets to display.  See http://stackoverflow.com/questions/23226627/automatic-gui-generating-in-r-shiny for more info.

The second tab shows how to create a simple grid of radio buttons.

The third tab shows how to place a grid of radio button widgets in a scrollable column, including a correction to CSS when `inline = TRUE`.

The fourth tab shows how to extract information from all of the widgets and display it in a table.

server.R is quite long.  In order to make it readable, user defined functions were moved to functions.R, which is sourced from ui.R.

**Formatting**

In general, when a block of code can be put in one line, it is.  When it cannot be, the closing bracket it placed at the end of last line of code (not on its own line).  One exception to this is the end of ui.R, where there are several lines of code with just a closing bracket.  

When there are sequential closing brackets, a space is added between them if the opening brackets are on different lines of code from each other.  If the opening brackets were on the same line, no space is placed between the closing brackets.

Comments describing code are placed immediately above the block of code

In server.R, sections of code that used by each tab start with a #### Comment ####



Currently, the term `WidgetVector` is used frequently in the code.  This is a misnomer, since the widgets are contained in a list.