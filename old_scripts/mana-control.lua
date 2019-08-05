--*  Peripherals  *--
 
local comperator = peripheral.wrap("top")
 
--*   Constants   *--
 
local MAX_SIGNAL = 15
local INTERVAL = 8
local OUTPUT_SIDE = "bottom"
local PAUSE_SIDE = "left"
 
--*   Variables   *--
 
local i = INTERVAL
 
--*   Functions   *--
 
--[[
  returns a pretty timestamp for logging
]]
function timeStamp()
  return ('d' .. os.day() .. ' ' .. textutils.formatTime(os.time(), true))
end
   
--[[
  logs a message and displays it on the term together with the current time
]]
function log(message)
  local x,y = term.getCursorPos()
  if (y == 19) then
    term.setCursorPos(1, 2)
  else
    term.setCursorPos(1, y + 1)
  end
  term.clearLine()
  term.write('[' .. timeStamp() .. ']: '  .. message )
end
   
--[[
  Displays a fancy headline with the current time on the term
]]
function fancyTerm()
  local x,y = term.getCursorPos()
  local t = timeStamp()
  term.setCursorPos(1, 1)
  term.setTextColor(colors.black)
  term.setBackgroundColor(colors.yellow)
  for i = 1, (51 - string.len(t)) do
    term.write(' ')
  end
  term.write(t)
  term.setCursorPos(x, y)
  term.setTextColor(colors.lightGray)
  term.setBackgroundColor(colors.black)
end
 
--*      Main     *--
term.clear()
 
while true do
  fancyTerm()
  redstone.setOutput(OUTPUT_SIDE, false)
  if not redstone.getInput(PAUSE_SIDE) then
    if (i == INTERVAL) then
      local manaAmount = comperator.getOutputSignal()
      if (manaAmount >= MAX_SIGNAL) then
        log("Mana pool is filled. Waiting for change.")
      else
        log("Filling mana pool. Activated TNT!")
        redstone.setOutput(OUTPUT_SIDE, true)
      end
      i = 0
    else
      i = i + 1
    end
  end
  sleep(1)
end