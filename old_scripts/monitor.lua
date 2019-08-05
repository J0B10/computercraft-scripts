-- Peripherals
local screen = peripheral.wrap("top")

-- Values
local label_back = "Pumps"
local label_right = "Fans"
local label_front = "Lights"
local label_left = nil

local screen_size_x,screen_size_y = screen.getSize()

-- Variables
local state_back = false
local state_right = true
local state_front = true
local state_left = false

-- Functions
local function paintButton(pos)
    if ((pos == 1) and not (label_back == nil)) then
        if (state_back) then
            screen.setBackgroundColor(colors.green)
        else
            screen.setBackgroundColor(colors.red)
        end
        screen.setTextColor(colors.black)
        local max_x = (screen_size_x - 4) / 2
        local max_y = (screen_size_y - 5) / 2
        for x=2,max_x do
            for y=3,max_y do
                screen.setCursorPos(x, y)
                screen.write(" ")
            end
        end
        local lbl_x = (max_x - 2 - string.len(label_back)) / 2 + 2
        local lbl_y = (max_y - 4) / 2 + 3
        screen.setCursorPos(lbl_x, lbl_y)
        screen.write(label_back)
    elseif ((pos == 2) and not (label_right)) == nil then
        if (state_right) then
            screen.setBackgroundColor(colors.green)
        else
            screen.setBackgroundColor(colors.red)
        end
        screen.setTextColor(colors.black)
        local start_x = screen_size_x / 2 + 2
        local start_y = 3
        local max_x = (screen_size_x - 2)
        local max_y = (screen_size_y - 5) / 2
        for x=start_x,max_x do
            for y=start_y,max_y do
                screen.setCursorPos(x, y)
                screen.write(" ")
            end
        end
        local lbl_x = (max_x - start_x - string.len(label_right)) / 2 + 2
        local lbl_y = (max_y - start_y) / 2 + 3
        screen.setCursorPos(lbl_x, lbl_y)
        screen.write(label_right)
    elseif ((pos == 3) and not (label_front == nil)) then
        if (state_front) then
            screen.setBackgroundColor(colors.green)
        else
            screen.setBackgroundColor(colors.red)
        end
        screen.setTextColor(colors.black)
        local start_x = 2
        local start_y = screen_size_y / 2 + 3
        local max_x = (screen_size_x - 4) / 2
        local max_y = (screen_size_y - 2)
        for x=start_x,max_x do
            for y=start_y,max_y do
                screen.setCursorPos(x, y)
                screen.write(" ")
            end
        end
        local lbl_x = (max_x - 2 - string.len(label_front)) / 2 + 2
        local lbl_y = (max_y - 4) / 2 + 3
        screen.setCursorPos(lbl_x, lbl_y)
        screen.write(label_front)
    elseif ((pos == 4) and not (label_left == nil)) then
        if (state_left) then
            screen.setBackgroundColor(colors.green)
        else
            screen.setBackgroundColor(colors.red)
        end
        screen.setTextColor(colors.black)
        local start_x = screen_size_x / 2 + 2
        local start_y = screen_size_y / 2 + 3
        local max_x = (screen_size_x - 2)
        local max_y = (screen_size_y - 2)
        for x=start_x,max_x do
            for y=start_y,max_y do
                screen.setCursorPos(x, y)
                screen.write(" ")
            end
        end
        local lbl_x = (max_x - 2 - string.len(label_left)) / 2 + 2
        local lbl_y = (max_y - 4) / 2 + 3
        screen.setCursorPos(lbl_x, lbl_y)
        screen.write(label_left)
    end
end

-- Main
screen.setBackgroundColor(colors.black)
screen.setTextScale(1)
screen.clear()
paintButton(1)
paintButton(2)
paintButton(3)
paintButton(4)