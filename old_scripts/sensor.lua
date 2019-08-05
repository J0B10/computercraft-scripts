--*  Peripherals  *--
 
local comp = peripheral.wrap("top")
 
--*   Constants   *--
 
local MAX_SIGNAL = 15
local INTERVAL = 1
local OUTPUT = {
  side = "front",
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
writeData(4, "Interval", INTERVAL)
writeData(6, "Output side", OUTPUT.side)
writeData(8, "Output color", OUTPUT.label)
 
local signal = nil
 
while true do
  local newSignal = comp.getOutputSignal()
  if (newSignal ~= signal) then
    signal = newSignal
    writeData(10, "Signal", signal)
  end
  if signal < MAX_SIGNAL then
    redstone.setBundledOutput(OUTPUT.side, OUTPUT.color)
    sleep(0.1)
    redstone.setBundledOutput(OUTPUT.side, 0)
    sleep(INTERVAL- 0.1)
  else
    sleep(INTERVAL)
  end
end