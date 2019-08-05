-- file:mana-clock.lua

--*  Peripherals  *--
 
local comp = peripheral.wrap("top")
 
--*   Constants   *--
 
local MAX_SIGNAL = 15
local INTERVAL = 5
local INPUT_SIDES = {
  "left",
  "right"
}
local OUTPUT_SIDE = "bottom"
local PAUSE_SIDE = "top"

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

local function writeColors(line, label, value)
  term.setCursorPos(3,line)
  term.setBackgroundColor(colors.black)
  term.clearLine()
  term.setTextColor(colors.yellow)
  term.write(label)
  term.write(":")
  for i = string.len(label), 14, 1 do
    term.write(" ")
  end
  for i=1,16 do
    local color = 2^(i-1)
    if colors.test(value,color) then
      term.setBackgroundColor(color)
      term.write("  ")
      term.setBackgroundColor(colors.black)
      term.write(" ")
    end
  end 
end
 
--*      Main     *--
term.clear()
 
if os.getComputerLabel() == nil then
  os.setComputerLabel("#".. os.getComputerID())
end
writeData(2, "Label", os.getComputerLabel())
writeData(4, "Output side", OUTPUT_SIDE)
writeData(6, "Interval", INTERVAL)
 
while true do
  if not redstone.getInput(PAUSE_SIDE) then
    local inputs = 0
    for i=1,table.getn(INPUT_SIDES) do
      inputs = colors.combine(inputs, redstone.getBundledInput(INPUT_SIDES[i]))
    end
    writeColors(8, "Signals", inputs)
    redstone.setBundledOutput(OUTPUT_SIDE , inputs)
    sleep(0.1)
    redstone.setBundledOutput(OUTPUT_SIDE, 0)
    sleep(INTERVAL - 0.1)
  else
    sleep(INTERVAL)
  end
end