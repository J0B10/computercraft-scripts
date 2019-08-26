local sensor = peripheral.wrap("right")
local range = 2.5

--check if there are any items nearby
local function areNearby() 
    local items = sensor.getEntityIds("ITEM")
    local item_data
    for i=1, #items do
        item_data = s.getEntityData(items[i], "ITEM").all()
        if math.abs(item_data.position.x) < range and 
                math.abs(item_data.position.y) < range and 
                math.abs(item_data.position.z) < range then
            if item_data.item.stack.id == "Botania:manaResource" and 
                    item_data.item.stack.dmg <= 2 then
                return true
            end
        end
    end
    return false
end

--check if alle ingridients are in the turtles inventory, 
--also returns a table with the slots of the ingridients
local function hasIngridients()
    local ingridients = {}
    local item
    for i=1, 16 do
        item = turtle.getItemDetail(i)
        if item ~= nil then
            if item.name == "Botania:manaResource" then
                if item.damage == 0 then
                    ingridients["manasteel"] = i
                elseif item.damage == 1 then
                    ingridients["manapearl"] = i
                elseif item.damage == 2 then
                    ingridients["manadiamond"] = i
                end
            end
        end
    end
    if ingridients["manasteel"] == nil or 
            ingridients["manadiamond"] == nil or 
            ingridients["manapearl"] == nil then
        return false, ingridients
    else
        return true, ingridients
    end
end

--main
while true do
    --wait till required ingredients are provided
    local found, ingridients = hasIngridients()
    while not found do
        os.pullEvent("turtle_inventory")
        found, ingridients = hasIngridients()
    end
    --wait till mana plate is free
    local nearby = areNearby()
    while nearby do
        sleep(0.6)
        nearby = areNearby()
    end
    --drop items
    turtle.select(ingridients.manasteel)
    turtle.drop(1)
    turtle.select(ingridients.manapearl)
    turtle.drop(1)
    turtle.select(ingridients.manadiamond)
    turtle.drop(1)
    turtle.select(1)
    --wait a second
    sleep(1)
end

