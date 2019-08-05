local screen = peripheral.wrap("top")

local state = false

local lbl = "Pump"

local function paint()
  if state then
    screen.setBackgroundColor(colors.green)
  else
    screen.setBackgroundColor(colors.red)
  end
  screen.clear()
  screen.setTextColor(colors.black)
  local size_x,size_y = screen.getSize()
  local x = (size_x - string.len(lbl)) / 2
  local y = (size_y - 1) / 2
  screen.setCursorPos(x,y)
  screen.write(lbl)
end

while true do
  paint()
  local side,x,y = os.pullEvent("monitor_touch")
  if state then
    state = false
  else
    state = true
  end
  redstone.setOutput("back", state)
  redstone.setOutput("left", state)
  redstone.setOutput("right", state)
  redstone.setOutput("front", state)
  redstone.setOutput("bottom", state)
end