local rune_Fire = {
    {
        name = "Thaumcraft:ItemShard",
        damage = 1,
        amount = 1
    },
    {
        name = "Botania:manaResource",
        damage = 0,
        amount = 3
    },
    {
        name = "minecraft:nether_brick",
        amount = 1
    },
    {
        name = "Botania:blazeBlock",
        amount = 1
    },
    {
        name = "minecraft:nether_wart",
        amount = 1,
        delay = 20
    },
    {
        name = "Botania:livingrock",
        damage = 0,
        amount = 1,
        delay = 1
    }
}

local rune_Water = {
    {
        name = "Thaumcraft:ItemShard",
        damage = 2,
        amount = 1
    },
    {
        name = "Botania:manaResource",
        damage = 0,
        amount = 3
    },
    {
        name = "minecraft:dye",
        damage = 15,
        amount = 1
    },
    {
        name = "minecraft:reeds",
        amount = 1
    },
    {
        name = "minecraft:fishing_rod",
        damage = 0,
        amount = 1,
        delay = 20
    },
    {
        name = "Botania:livingrock",
        damage = 0,
        amount = 1,
        delay = 1
    }
}

local rune_Earth = {
    {
        name = "Thaumcraft:ItemShard",
        damage = 3,
        amount = 1
    },
    {
        name = "Botania:manaResource",
        damage = 0,
        amount = 3
    },
    {
        name = "minecraft:stone",
        amount = 1
    },
    {
        name = "minecraft:coal_block",
        amount = 1
    },
    {
        name = "minecraft:red_mushroom",
        amount = 1,
        delay = 20
    },
    {
        name = "Botania:livingrock",
        damage = 0,
        amount = 1,
        delay = 1
    }
}


local rune_Air = {
    {
        name = "Thaumcraft:ItemShard",
        damage = 0,
        amount = 1
    },
    {
        name = "Botania:manaResource",
        damage = 0,
        amount = 3
    },
    {
        name = "minecraft:carpet",
        amount = 1
    },
    {
        name = "minecraft:feather",
        amount = 1
    },
    {
        name = "minecraft:string",
        amount = 1
    }
}

assert(os.loadAPI("autocraft"), "could not load autocraft api")

autocraft.craft(true, rune_Fire, rune_Water, rune_Earth, rune_Air)