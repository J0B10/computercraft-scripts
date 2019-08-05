-- file:mana-detector.lua

--*  Peripherals  *--
 
local comp = peripheral.wrap("top")
 
--*   Constants   *--
 
local MAX_SIGNAL = 15
local INTERVAL = 1
local INPUT = {
  side = nil
}
local OUTPUT = {
  side = "right",
  label = "purple",
  color = colors.purple
}

--*   Functions   *--
 
local function writeData(line,label,value)  
  term.setCursorPos(3,line)
  term.setBackgroundColor(colors.black)
  term.setTextColor(colors.yellow)
  term.write(label)
  term.write(":")
  for i = string.len(label), 14, 1 do
    term.write(" ")
  end
  term.setBackgroundColor(colors.yellow)
  term.setTextColor(colors.black)
  for i = string.len(value), 12, 1 do
    term.write(" ")
  end
  term.write(value)
end
 
--*      Main     *--
term.clear()
 
if os.getComputerLabel() == nil then
  os.setComputerLabel("#".. os.getComputerID())
end
writeData(2, "Label", os.getComputerLabel())
writeData(4, "Output color", OUTPUT.label)
 
local signal = nil
 
while true do
  local newSignal = comp.getOutputSignal()
  if (newSignal ~= signal) then
    signal = newSignal
    writeData(6, "Signal", signal)
  end
  local input = 0
  if INPUT.side ~= nil then input = redstone.getBundledInput(INPUT.side) end
  if signal < MAX_SIGNAL then
    redstone.setBundledOutput(OUTPUT.side, colors.combine(input, OUTPUT.color))
  else
    redstone.setBundledOutput(OUTPUT.side, input)
  end
  sleep(INTERVAL)
end