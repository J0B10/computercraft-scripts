
-- ingridients:
local tnt = -1
local dragonHeart = -1 
local draconicCore = -1
local draconium = -1


--search for the required items in the turtles inventory
local function findItems()
    tnt = -1
    dragonHeart = -1 
    draconicCore = -1
    draconium = -1
    for i=1, 16 do
        local item = turtle.getItemDetail(i)
        if item ~= nil then
            if item.name == "minecraft:tnt" then
                tnt = i
            elseif item.name == "DraconicEvolution:draconicCore"  and item.count >= 16 then
                draconicCore = i
            elseif item.name == "DraconicEvolution:draconium" and item.damage == 2 and item.count >= 4 then
                draconium = i
            elseif item.name == "DraconicEvolution:dragonHeart" then
                dragonHeart = i
            end
        end
    end
    return tnt ~= -1 and dragonHeart ~= -1 and draconicCore ~= -1 and draconium ~= -1
end

--perform the ritual
local function ritual()
    turtle.select(tnt)
    turtle.drop(1)
    sleep(3.7)
    turtle.select(dragonHeart)
    turtle.drop(1)
    sleep(8)
    turtle.select(draconicCore)
    turtle.drop(16)
    sleep(3)
    turtle.select(draconium)
    turtle.drop(4)
    sleep(21)
end

while true do
    if findItems() then
        ritual()
    else
        sleep(0.2)
    end
end
