-- Create dir
if not fs.isDir("me-registry") then
    fs.makeDir("me-registry")
end

-- Registry
local registry = {
    { name = "north", file = shell.resolve("me-registry/north.txt") },
    { name = "east", file = shell.resolve("me-registry/east.txt") },
    { name = "south", file = shell.resolve("me-registry/south.txt") },
    { name = "west", file = shell.resolve("me-registry/west.txt") },
    { name = "top", file = shell.resolve("me-registry/top.txt") },
    { name = "bottom", file = shell.resolve("me-registry/bottom.txt") },
}

local selected = 1

-- UI

multishell.setTitle(multishell.getCurrent(), "Side")

while true do
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1,1)
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.black)
    term.clearLine()
    term.write(" Side")
    for i,value in ipairs(registry) do
        term.setCursorPos(5,i * 2 + 1)
        if i == selected then
            term.setTextColor(colors.black)
            term.setBackgroundColor(colors.yellow)
        else
            term.setTextColor(colors.yellow)
            term.setBackgroundColor(colors.black)
        end
        term.clearLine()
        term.write(value.name)
    end
    local loop = true
    while loop do
        loop = false
        local event, key = os.pullEvent("key")
        if key == keys.down then
            if table.getn(registry) > selected then 
                selected = selected + 1
            end
        elseif key == keys.up then
            if 1 < selected then 
                selected = selected - 1
            end
        elseif key == keys.enter then
            local tabID = shell.openTab("edit", registry[selected].file)
            multishell.setTitle(tabID, registry[selected].name)
            term.setBackgroundColor(colors.black)
            multishell.setFocus(tabID)
        else
            loop = true
        end
    end
end