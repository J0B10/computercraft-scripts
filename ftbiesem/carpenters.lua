local me  = peripheral.wrap("top")

local function getCraftable()
    local gold = me.getItemDetail({id="minecraft:gold_ingot"},false)
    if gold == nil then 
        return 0
    else
        return math.floor(gold.qty / 3)
    end
end

while true do
    local cpus = me.getCraftingCPUs()
    local free = 0
    for i=0, #cpus do
        if not cpus[i].busy then
            free = free + 1
        end
    end
    local craftable = getCraftable()
    local i = 1
    while i <= craftable and i<=free do
        me.requestCrafting({id="Forestry:chipsets", dmg=3}, 1)
    end
    sleep(0.5)
end