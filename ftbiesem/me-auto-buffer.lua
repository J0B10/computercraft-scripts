--Peripherals
local inv = peripheral.wrap("top")
local me = peripheral.wrap("bottom")

-- cpus that should be used
local cpus = {}

--stuff that should be buffered
local buffer = {}



--update buffer to match chest content
local function updateBuffer()
    local content = inv.getAllStacks(false)
    local buffer_entry
    for i,value in ipairs(content) do
        if value ~= nil then
            buffer_entry = { 
                id = value.id,
                dmg = value.dmg,
                display_name = value.display_name,
                amount = 2 ^ value.qty,
                missing = true,
                requested = false,
                present = 0
            }
            table.insert(buffer, buffer_entry)
        end
    end
end

--check if all the stuff is buffered in the system or if new should be requested
local function checkContents()
    for i=1, #buffer do
        local detail = me.getItemDetail({id = buffer[i].id, dmg = buffer[i].dmg}, false)
        if detail == nil then 
            buffer[i].present = 0
            buffer[i].missing = true
        else
            buffer[i].present = detail.qty
            if detail.qty < buffer[i].amount then
                buffer[i].missing = true
            else
                buffer[i].missing = false
            end
        end
    end
end

--find a free cpu for crafting
local function freeCPU() 
    local all_cpus =table.sort(me.getCraftingCPUs(), function(a,b) return a.storage < b.storage end)
    for i=1, #all_cpus do
        if not all_cpus[i].busy then
            for j=1, #cpus do
                if all_cpus[i].name == cpus[j] then
                    return cpus[j]
                end
            end 
        end
    end
    return nil
end

local function requestMissing()
    for i=1, #buffer do
        if buffer[i].missing and (not buffer[i].requested) then
        end
    end
end

local scroll_index = 1
local size_x, size_Y = term.getSize()

--display list on term
local function display()
    term.setBackgroundColor(colors.black)
    term.clear()
    for i=1, size_Y do
        local value = buffer[scroll_index + i - 1]
        if value ~= nil then 
            if value.missing then
                term.setTextColor(colors.red)
            else
                term.setTextColor(colors.white)
            end
            term.setCursorPos(1,i)
            term.write("(" .. value.present .. "/" .. value.amount .. ") " .. value.display_name)
        end
    end
end

--scroll up and down with the mouse
local function scroll()
    while true do
        local event, scrollDirection, x, y = os.pullEvent("mouse_scroll")
        if scrollDirection == -1 then --scroll up
            if scroll_index > 1 then 
                scroll_index = scroll_index - 1
                display()
            end
        elseif scrollDirection == 1 then --scroll down
            if scroll_index + size_Y - 1 < #buffer then
                scroll_index = scroll_index + 1
                display()
            end
        end
    end
end

updateBuffer()
checkContents()
display()
scroll()