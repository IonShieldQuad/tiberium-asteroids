require("prototypes.entity.asteroid")
require("prototypes.items.tiberium-asteroid-chunk")
require("prototypes.recipes.tiberium-asteroid-crushing")
require("util")
data:extend({
    {
        type = "storage-tank",
        name = "tib-dummy-storage-tank",
        hidden = true,
        flags = { "placeable-neutral", "not-on-map" },
        window_bounding_box = { { 0, 0 }, { 0, 0 } },
        flow_length_in_ticks = 1,
        show_fluid_icon = false,
        fluid_box = {
            volume = 10000000,
            pipe_connections = {},
        },
        max_health = 1,
        create_ghost_on_death = false,
        icon = "__Factorio-Tiberium__/graphics/icons/tiberium-ore.png",
        icon_size = 64,
        collision_box = { { 0, 0 }, { 0, 0 } },
        selection_box = { { 0, 0 }, { 0, 0 } },
        collision_mask = { layers = { empty_space = true }, not_colliding_with_itself = true }
    }
})

data:extend({
    {
        type = "selection-tool",
        name = "tiberium-asteroid-remote",
        icon = "__tiberium-asteroids__/graphics/icons/tiberium-asteroid-remote.png",
        icon_size = 64,
        flags = {  },
        subgroup = "a-items",
        order = "z[tiberium-asteroid-remote]",
        stack_size = 1,
        select = {
            border_color = { r = 1, g = 0.2, b = 0.2 },
            cursor_box_type = "entity",
            mode = "nothing",
        },
        alt_select = {
            border_color = { r = 0, g = 1, b = 0 },
            cursor_box_type = "not-allowed",
            mode = "nothing"
        },
        skip_fog_of_war = true,
        hidden = true,
        hidden_in_factoriopedia = true
    }
})


data:extend({
    {
        type = "sprite",
        name = "huge-tiberium-asteroid-fall",
        layers = {
            {
                filename = "__tiberium-asteroids__/graphics/entity/asteroid/tiberium/huge/asteroid-tiberium-huge-colour-01.png",
                height = 512,
                width = 512,
                priority = "high",
                scale = 2
            },
            --[[{
                filename =
                "__base__/graphics/entity/cargo-pod/pod-open-reentry-flame.png",
                height = 272,
                width = 306,
                priority = "high",
                scale = 2.5,
                blend_mode = "additive",
                draw_as_glow = true,
                --shift = util.by_pixel()
            },--]]
            {
                filename =
                "__tiberium-asteroids__/graphics/entity/asteroid/tiberium/huge/asteroid-tiberium-huge-colour-01.png",
                height = 512,
                width = 512,
                priority = "high",
                scale = 2,
                blend_mode = "additive",
                draw_as_glow = true,
                tint = {0.1, 0.5, 0.1, 0.5}
            }
        }
    }
})


data:extend({
    {
        type = "sound",
        name = "tiberium-asteroid-reentry",
        filename = "__tiberium-asteroids__/sounds/meteor.ogg",
        audible_distance_modifier = 1,
        priority = 4,
        volume = 4,
        category = "alert"
    }
})