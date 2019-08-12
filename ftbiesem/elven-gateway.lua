
-- waits for item input and activates mana portal if needed...
-- after some time it deactivates the portal agian...

local redstone_side = "bottom"

local redstone_colors = {
    piston = colors.red,
    activator = colors.blue
}

local sleep_time = 10 * 60

local portal_active = false
local portal_charging = false

--get the first slot that contains items. -1 if inventory is empty
local function findItems()
    for i=1, 16 do
        if turtle.getItemCount(i) > 0 then
            return i
        end
    end
    return -1
end

--waits till items are found in the inventory, then activates the portal (if necessary) and drops them
local function transform()
    local slot = findItems()
    while slot < 0 do
        os.pullEvent("turtle_inventory")
        slot = findItems()
    end
    turtle.select(slot)
    if not portal_active then 
        redstone.setBundledOutput(redstone_side, redstone_colors.piston + redstone_colors.activator)
        sleep(0.5)
        redstone.setBundledOutput(redstone_side, redstone_colors.piston)
        portal_active = true
        portal_charging = true
        sleep(7)
        portal_charging = false
    end
    turtle.drop()
end

--waits for a long tine and then shuts down the portal
local function idle()
    sleep(sleep_time)
    while portal_charging do 
        sleep(10)
    end
    redstone.setBundledOutput(redstone_side, 0)
    portal_active = false
    sleep(0.2)
    redstone.setBundledOutput(redstone_side, redstone_colors.piston)
end

while true do
    parallel.waitForAny(transform, idle)
end