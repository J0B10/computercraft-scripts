local sensor = peripheral.wrap("right")
local range = 2.5

--check if there are any items nearby
local function areNearby() 
    local items = sensor.getEntityIds("ITEM")
    local item_data
    for i=1, #items do
        item_data = sensor.getEntityData(items[i], "ITEM").all()
        if math.abs(item_data.position.x) < range and 
                math.abs(item_data.position.y) < range and 
                math.abs(item_data.position.z) < range then
            if item_data.item.stack.id == "Botania:manaResource" then
                return true
            end
        end
    end
    return false
end

--check if alle ingredients are in the turtles inventory, 
--also returns a table with the slots of the ingredients
local function hasingredients()
    local ingredients = {}
    local item
    for i=1, 16 do
        item = turtle.getItemDetail(i)
        if item ~= nil then
            if item.name == "Botania:manaResource" then
                if item.damage == 0 then
                    ingredients["manasteel"] = i
                elseif item.damage == 1 then
                    ingredients["manapearl"] = i
                elseif item.damage == 2 then
                    ingredients["manadiamond"] = i
                end
            end
        end
    end
    if ingredients["manasteel"] == nil or 
            ingredients["manadiamond"] == nil or 
            ingredients["manapearl"] == nil then
        return false, ingredients
    else
        return true, ingredients
    end
end

--main
while true do
    --wait till required ingredients are provided
    local found, ingredients = hasingredients()
    while not found do
        os.pullEvent("turtle_inventory")
        found, ingredients = hasingredients()
    end
    --wait till mana plate is free
    local nearby = areNearby()
    while nearby do
        sleep(0.6)
        nearby = areNearby()
    end
    --drop items
    turtle.select(ingredients.manasteel)
    turtle.drop(1)
    turtle.select(ingredients.manapearl)
    turtle.drop(1)
    turtle.select(ingredients.manadiamond)
    turtle.drop(1)
    turtle.select(1)
    --wait a second
    sleep(1)
end

