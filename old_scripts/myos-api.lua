--*   Colors   *--
ACCENT_COLOR =  colors.yellow
ACCENT_TEXT_COLOR = colors.black
BACKGROUND_COLOR = colors.black
TEXT_COLOR = colors.yellow

--*   Config   *--
LOG_DAY = true

--*  Functions *--

--- @return a pretty timestamp for logging
function timeStamp()
  if LOG_DAY then
    return ('d' .. os.day() .. ' ' .. textutils.formatTime(os.time(), true))
  else
    return (textutils.formatTime(os.time(), true))
  end
end
 
--- logs a message and displays it on the term together with the current time
function log(message)
  local x,y = term.getCursorPos()
  if (y == 19) then
    term.setCursorPos(1, 2)
  else
    term.setCursorPos(1, y + 1)
  end
  term.setBackgroundColor(BACKGROUND_COLOR)
  term.setTextColor(TEXT_COLOR)
  term.clearLine()
  term.write('[' .. timeStamp() .. ']: '  .. message)
end
 
--- Displays a fancy headline with the current time on the term 
-- Must be called each second
function fancyTerm()
  local x,y = term.getCursorPos()
  local t = timeStamp()
  local label = getLabel()
  term.setCursorPos(1, 1)
  term.setTextColor(ACCENT_COLOR)
  term.setBackgroundColor(ACCENT_TEXT_COLOR)
  term.write(label)
  for i = 1, (51 - string.len(t) - string.len(label)) do
    term.write(' ')
  end
  term.write(t)
  term.setCursorPos(x, y)
  term.setBackgroundColor(BACKGROUND_COLOR)
  term.setTextColor(TEXT_COLOR)
end
 
--- Setup the term, display the fancy headline and change the background
function setup()
  term.setBackgroundColor(BACKGROUND_COLOR)
  term.clear()
  fancyTerm()
end

--- @return the label of the computer. If not set use the id
local function getLabel()
  if os.getComputerLabel() == nil then
    os.setComputerLabel("#" .. os.getComputerID())
  end
  return os.getComputerLabel()
end

--- Display some data on the term
function writeData(line, label, value, labelColor, valueColor, valueBackgroundColor, labelLength, valueLength, indent)
  labelColor = labelColor or TEXT_COLOR
  valueColor = valueColor or ACCENT_TEXT_COLOR
  valueBackgroundColor = valueBackgroundColor or ACCENT_COLOR
  labelLength = labelLength or 14
  valueLength = valueLength or 12
  indent = indent or 3
  term.setCursorPos(indent,line)
  term.setBackgroundColor(BACKGROUND_COLOR)
  term.setTextColor(labelColor)
  term.write(label)
  term.write(":")
  for i = string.len(label), labelLength, 1 do
    term.write(" ")
  end
  term.setBackgroundColor(valueBackgroundColor)
  term.setTextColor(valueColor)
  for i = string.len(value), valueLength, 1 do
    term.write(" ")
  end
  term.write(value)
end