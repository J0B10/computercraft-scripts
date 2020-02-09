local awakenedDraconium = {
    {
        name = "minecraft:tnt",
        amount = 1,
        delay = 3.7
    },
    {
        name = "DraconicEvolution:dragonHeart",
        amount = 1,
        delay = 8
    },
    {
        name = "DraconicEvolution:draconicCore",
        amount = 16,
        delay = 3
    },
    {
        name = "DraconicEvolution:draconium",
        damage = 2,
        amount = 4,
        delay = 21
    }
}

assert(os.loadAPI("autocraft"), "could not load autocraft api")

autocraft.craft(true, awakenedDraconium)