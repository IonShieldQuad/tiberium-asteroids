data:extend({
    {
        type = "recipe",
        name = "tiberium-asteroid-crushing",
        icon = "__tiberium-asteroids__/graphics/icons/tiberium-asteroid-crushing.png",
        category = "crushing",
        subgroup = "space-crushing",
        order = "b-a-t",
        auto_recycle = false,
        enabled = false,
        ingredients =
        {
            { type = "item", name = "tiberium-asteroid-chunk", amount = 1 },
        },
        energy_required = 2,
        results =
        {
            { type = "item", name = "tiberium-ore",            amount = 20 },
            { type = "item", name = "tiberium-asteroid-chunk", amount = 1, probability = 0.2 }
        },
        allow_productivity = true,
        allow_decomposition = false
    },
    {
        type = "recipe",
        name = "advanced-tiberium-asteroid-crushing",
        localised_name = { "recipe-name.advanced-tiberium-asteroid-crushing" },
        icon = "__tiberium-asteroids__/graphics/icons/advanced-tiberium-asteroid-crushing.png",
        category = "crushing",
        subgroup = "space-crushing",
        order = "c-a-t",
        auto_recycle = false,
        enabled = false,
        ingredients =
        {
            { type = "item", name = "tiberium-asteroid-chunk", amount = 1 }
        },
        energy_required = 5,
        results =
        {
            { type = "item", name = "tiberium-ore",            amount = 15 },
            { type = "item", name = "tiberium-ore-blue",       amount = 10, probability = 0.1 },
            { type = "item", name = "tiberium-asteroid-chunk", amount = 1,  probability = 0.05 }
        },
        allow_productivity = true,
        allow_decomposition = false
    },
})


local tech1 = data.raw["technology"]["space-platform"]
if mods["planet-muluna"] then
    tech1 = data.raw["technology"]["planet-discovery-muluna"]

    if tech1 == nil then
        for name, techi in pairs(data.raw["technology"]) do
            found = false
            if not string.find(name, "advanced") and not string.find(name, "productivity") then
                for _, effect in ipairs(techi.effects or {}) do
                    ---@diagnostic disable-next-line: undefined-field
                    if effect == "unlock-recipe" and effect.recipe and string.find(effect.recipe, "crusher") and found == false then
                        found = true
                        tech1 = techi
                    end
                end
            end
        end
    end
end
if tech1 == nil then
    tech1 = data.raw["technology"]["space-platform"]
end
table.insert(tech1.effects, {
    type = "unlock-recipe",
    recipe = "tiberium-asteroid-crushing"
})

local tech2 = data.raw["technology"]["advanced-asteroid-processing"]
table.insert(tech2.effects, {
    type = "unlock-recipe",
    recipe = "advanced-tiberium-asteroid-crushing"
})


local tech3 = data.raw["technology"]["asteroid-productivity"]
table.insert(tech3.effects, {
    type = "change-recipe-productivity",
    recipe = "tiberium-asteroid-crushing",
    change = 0.1
})
table.insert(tech3.effects, {
    type = "change-recipe-productivity",
    recipe = "advanced-tiberium-asteroid-crushing",
    change = 0.1
})
