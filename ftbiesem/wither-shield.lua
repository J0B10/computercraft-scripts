local battery = peripheral.wrap("right")


--load the last setting for the shield
local function loadState()
    if fs.exists(".shield-state.cfg") then
        return fs.open(".shield-state.cfg", "r").readAll() == "true"
    else
        return false
    end
end

local active = loadState()

local term_x,term_y = term.current().getSize()
local button = window.create(term.current(), (term_x - 15) / 2, (term_y - 3) / 2, 15, 3)

--print the state button on term
local function paint_button()
    button.setTextColor(colors.black)
    if active then
        button.setBackgroundColor(colors.lime)
    else 
        button.setBackgroundColor(colors.lightGray)
    end
    button.clear()
    button.setCursorPos(5,2)
    if active then
        button.write("Shield On")
    else
        button.write("Shield Off")
    end
end

--checks if the coordinates are inside that window
local function isInside(window, x, y)
    local x_min,y_min = window.getPosition()
    local x_size,y_size = window.getSize()
    return x >= x_min and x < (x_min + x_size) and y >= y_min and y < (y_min + y_size)
end

--handles button presses
local function button_listener()
    paint_button()
    local event,arg1,x,y = os.pullEvent()
    if event == "mouse_click" or event == monitor_touch then
        if isInside(button, x, y) then
            local f = fs.open(".shield-state.cfg", "w")
            if active then
                active = false
                f.write("false")
            else
                active = true
                f.write("true")
            end
            f.close()
        end
    end 
end

--main function for sheild control
local function control()
    while true do
        if active then 
            redstone.setOutput("right", false)
            if battery.getEnergyStored() < battery.getMaxEnergyStored() - 1000 then
                redstone.setOutput("left", false)
            else
                redstone.setOutput("left", true)
            end
        else
            redstone.setOutput("left", false)
            redstone.setOutput("right", true)
        end
        sleep(0.5)
    end
end

--main

button.setVisible(true)

term.clear()
term.setBackgroundColor(colors.yellow)
term.setTextColor(colors.black)
term.setCursorPos(1,1)
term.clearLine()
term.write(os.getComputerLabel())

while true do
    parallel.waitForAny(control,button_listener)
end