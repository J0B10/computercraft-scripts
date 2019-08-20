local reactor = peripheral.wrap("top")

local max_heat = 0.6


--load the last setting for the reactor
local function loadState()
    if fs.exists(".reactor-state.cfg") then
        return fs.open(".reactor-state.cfg", "r").readAll() == "true"
    else
        return false
    end
end

local active = loadState()

local term_x,term_y = term.current().getSize()
local window_state = window.create(term.current(), (term_x - 30) / 3, (term_y - 3) / 2, 15, 3)
local window_heat = window.create(term.current(), (term_x - 30) / 3 * 2 + 15, (term_y - 3) / 2, 15, 3)

--get the current reactor heat in percent
local function getHeat()
    if reactor.getHeat() == 0 then 
        return 0
    else
        return reactor.getMaxHeat() / reactor.getHeat()
    end
end

--print the state button on term
local function paint_state()
    window_state.setTextColor(colors.black)
    if active then
        window_state.setBackgroundColor(colors.lime)
    else 
        window_state.setBackgroundColor(colors.lightGray)
    end
    window_state.clear()
    window_state.setCursorPos(5,2)
    if active then
        window_state.write("Running")
    else
        window_state.write("Shut down")
    end
end

--print the current heat on term
local function paint_heat()
    local heat = getHeat()
    window_heat.setTextColor(colors.black)
    if heat <= max_heat then
        window_heat.setBackgroundColor(colors.lightBlue)
    else 
        window_heat.setBackgroundColor(colors.red)
    end
    window_heat.clear()
    window_heat.setCursorPos(5,2)
    window_heat.write("Heat: " .. math.floor(heat * 100) .. "%")
end

--main function for reactor control
local function control()
    while true do
        if getHeat() > max_heat then
            redstone.setOutput("top", false)
        else
            redstone.setOutput("top", active)
        end
        paint_heat()
        sleep(1)
    end
end

--checks if the coordinates are inside that window
local function isInside(window, x, y)
    local x_min,y_min = window.getPosition()
    local x_size,y_size = window.getSize()
    return x >= x_min and x < (x_min + x_size) and y >= y_min and y < (y_min + y_size)
end

--handles button presses
local function button()
    paint_state()
    local event,arg1,x,y = os.pullEvent()
    if event == "mouse_click" or event == monitor_touch then
        if isInside(window_state, x, y) then
            local f = fs.open(".reactor-state.cfg", "w")
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

--main

window_state.setVisible(true)
window_heat.setVisible(true)

term.clear()
term.setBackgroundColor(colors.yellow)
term.setTextColor(colors.black)
term.setCursorPos(1,1)
term.clearLine()
term.write(os.getComputerLabel())

while true do
    parallel.waitForAny(control,button)
end