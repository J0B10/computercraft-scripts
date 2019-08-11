--Peripherals
local inv = peripheral.wrap("top")
local me = peripheral.wrap("bottom")

--stuff that should be buffered
local buffer = {}

--update buffer to match chest content
local function updateBuffer()
    local content = inv.getAllStacks(true)
    local buffer_entry
    for i,value in ipairs(content) do
        if value ~= nil then
            buffer_entry = { 
                id = value.id,
                dmg = value.dmg,
                display_name = value.display_name,
                amount = 2 ^ value.qty
            }
            table.insert(buffer, buffer_entry)
        end
    end
end

local scroll = 1
local size_x, size_Y = term.getSize()

--display list on term
local function display()
    term.setBackgroundColor(colors.black)
    term.clear()
    for i=1, size_Y do
        local value = buffer[scroll + i - 1]
        if value ~= nil then 
            term.setCursorPos(1,i)
            term.write("(" .. "0" .. "/" .. value.amount .. ") " .. value.display_name)
        end
    end
end

--scroll up and down with the mouse
local function scroll()
    while true do
        local event, scrollDirection, x, y = os.pullEvent("mouse_scroll")
        if scrollDirection == -1 then --scroll up
            if scroll > 1 then 
                scroll = scroll - 1
                display()
            end
        elseif scrollDirection == 1 then --scroll down
            if scroll + size_Y - 1 < #buffer then
                scroll = scroll + 1
                display()
            end
        end
    end
end

display()
scroll()