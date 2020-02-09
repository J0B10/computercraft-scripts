--example recipe
--[[
local recipe = {
    {
        name = "minecraft:stone",
        amount = 1,
        delay = 0.1
    },
    {
        name = "minecraft:dirt",
        damage = 0,
        amount = 5,
        onDrop = function() print("Dropped dirt") end
    }
}
]]--

--craft the given recipes by using the items in the turtles inventory
function craft(loop, ...)
    while true do
        assert(arg, "no recipes provided")
        for i, recipe in ipairs(arg) do
            if contains(recipe) then
                performCraft(recipe)
                break
            end 
        end
        if loop then 
            sleep (0.2)
        else
            return
        end
    end
end

--check if the inventory contains all ingredients of a recipe
function contains(recipe)
    assert(recipe, "recipe is nil")
    for i, ingredient in ipairs(recipe) do
        assert(ingredient.name, "invalid ingredient 'unknown "..i.."': name is missing")
        assert(ingredient.amount, "invalid ingredient '"..ingredient.name.."': amount is missing")
        local found = 0
        for slot=1,16 do
            local item = turtle.getItemDetail(slot)
            if item ~= nil and item.name == ingredient.name then
                if ingredient.damage == nil or ingredient.damage == item.damage then
                    found = found + item.count
                    if found >= ingredient.amount then
                        break
                    end
                end
            end
        end
        if found < ingredient.amount then 
            return false
        end
    end
    return true
end

--drop all ingredients required to craft the recipe
local function performCraft(recipe)
    assert(recipe, "recipe is nil")
    for i, ingredient in ipairs(recipe) do
        assert(ingredient.name, "invalid ingredient 'unknown': name is missing")
        assert(ingredient.amount, "invalid ingredient '"..ingredient.name.."': amount is missing")
        local dropped = 0
        for slot=1,16 do
            local item = turtle.getItemDetail(slot)
            if item ~= nil and item.name == ingredient.name then
                if ingredient.damage == nil or ingredient.damage == item.damage then
                        turtle.select(slot)
                    if (dropped + item.count) >= ingredient.amount then
                        turtle.drop(ingredient.amount - dropped)
                        dropped = ingredient.amount
                        break
                    else 
                        turtle.drop(item.count)
                        dropped = dropped + item.count
                    end
                end
            end
        end
        assert(dropped == ingredient.amount, "'"..ingredient.name.. "': items missing")
        if ingredient.onDrop ~= nil then
            ingredient.onDrop()
        end
        if ingredient.delay ~= nil then
            sleep(ingredient.delay)
        end
    end
end

