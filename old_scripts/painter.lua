local painter = peripheral.wrap('right')
local FACADE_SLOT = 1
local PAINT_SLOT = 2
local OUTPUT_SLOT = 3
local FACADE_SIDE = 'east'
local OUTPUT_SIDE = 'north'
local PAINT_SIDE = 'down'
local REDSTONE_SIDE = 'top'
local SLEEP_SECONDS = 0.5
local PRODUCE_AMOUNT = 16
 
local ERROR = {
  output = false,
  facade = false,
  power = false
}
 
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
 
--[[
  Applys a redstone signal (for an error light or simmilar) if an error occured
]]
function warn()
  if (ERROR.output or ERROR.facade or ERROR.power) then
    redstone.setAnalogOutput(REDSTONE_SIDE, 15)
  else
    redstone.setAnalogOutput(REDSTONE_SIDE, 0)
  end
end
 
--[[
  output all produced items into me system
  returns if output was successfull
]]
function output()
  local amount = painter.pushItem(OUTPUT_SIDE, OUTPUT_SLOT)
  if amount > 0 then
    log('Exported ' ..  amount .. ' items')
    ERROR.output = false
  else
    log("Couldn't export items ")
    ERROR.output = true
  end
  return amount > 0
end
 
--[[
  tries to input one item from the paint material from adjacent inventory
  returns if item was inputed successfull
]]
function inputPaint()
  local amount = painter.pullItem(PAINT_SIDE, 1, 1, PAINT_SLOT)
  if amount > 0 then
    log('Inserted 1 paint item')
  end
  return amount > 0
end
 
--[[
  tries to input a stack of facades from adjacent inventory
  returns if any facades could be insert
]]
function inputFacades()
  local amount = painter.pullItem(FACADE_SIDE, 1, 64, FACADE_SLOT)
  if amount > 0 then
    log('Inserted ' .. amount .. ' facades')
  end
  return amount > 0
end
 
--[[
  Tries to resupply all facades
]]
function resupplyFacades()
  if (painter.getStackInSlot(FACADE_SLOT) == nil or painter.getStackInSlot(FACADE_SLOT).qty < 32) then
    if (not inputFacades()) then
      if (ERROR.facade == false) then
        log('Painter run out of facades...')
      end
      ERROR.facade = true
    else
      ERROR.facade = false
    end
  end
end
 
--[[
  Check if the output stack is full
]]
function shouldOutput()
  if (painter.getStackInSlot(OUTPUT_SLOT) == nil) then
    return false
  else
    return painter.getStackInSlot(OUTPUT_SLOT).qty >= PRODUCE_AMOUNT
  end
end
 
--[[
  Check if the machine has enough energy
]]
function checkPower()
  if (painter.getEnergyStored() < 50000) then
    if (ERROR.power == false) then
      log('Painter runs out of energy soon...')
    end
    ERROR.power = true
  else
    ERROR.power = false
  end
end
 
 
 
--[[ MAIN ]]--
 
while true do
  fancyTerm()
  resupplyFacades()
  if (painter.getStackInSlot(PAINT_SLOT) == nil) then
    inputPaint()
  else
    if (shouldOutput()) then
      output()
      painter.destroyStack(PAINT_SLOT)
    end
  end
  checkPower()
  warn()
  os.sleep(SLEEP_SECONDS)
end