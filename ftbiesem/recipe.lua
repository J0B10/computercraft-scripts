local selected = turtle.getSelectedSlot() 

local ingredients = {}
local result = turtle.getItemDetail(selected) 

for i=1, 16 do
    if i ~= selected then
        table.insert(ingredients, turtle.getItemDetail(i))
    end
end

if result == nil or #ingredients == 0 then
    print("Please put the ingredients in the turtle inventory and the result in the selected slot.")
    return
end 

local recipe = {
    recipe = ingredients,
    result = result
}
local recipes
if fs.exists("recipes.json") then
    local file = fs.open("recipes.json", "r")
    recipes = textutils.unserialize(file.readAll())
    file.close()
else 
    recipes = {}
end
table.insert(recipes, recipe)
local file = fs.open("recipes.json", "w")
file.write(textutils.serialize(recipes))
file.close()
print("Successfully saved recipe!")