local smoke_animations = require("__base__.prototypes.entity.smoke-animations")
local util = require("util")

local smoke_fast_animation = smoke_animations.trivial_smoke_fast
local trivial_smoke = smoke_animations.trivial_smoke


data:extend({
    -- tiberium smoke
    trivial_smoke {
        name = "asteroid-smoke-tiberium-chunk",
        color = { 0.22, 0.8, 0.1, 0.3 },
        affected_by_wind = false,
        render_layer = "elevated-object",
        duration = 80,
        start_scale = 0.5,
        end_scale = 0.7,
        spread_duration = 1,
        movement_slow_down_factor = 1,
    },
    trivial_smoke {
        name = "asteroid-smoke-tiberium-small",
        color = { 0.22, 0.8, 0.1, 0.3 },
        affected_by_wind = false,
        render_layer = "elevated-object",
        duration = 90,
        start_scale = 0.5,
        end_scale = 1,
        spread_duration = 6,
        movement_slow_down_factor = 1,
    },
    trivial_smoke {
        name = "asteroid-smoke-tiberium-medium",
        color = { 0.22, 0.8, 0.1, 0.3 },
        affected_by_wind = false,
        render_layer = "elevated-object",
        duration = 100,
        start_scale = 0.8,
        end_scale = 1,
        fade_in_duration = 2,
        spread_duration = 10,
        movement_slow_down_factor = 1,
    },
    trivial_smoke {
        name = "asteroid-smoke-tiberium-big",
        color = { 0.22, 0.8, 0.1, 0.3 },
        affected_by_wind = false,
        render_layer = "elevated-object",
        duration = 120,
        start_scale = 1,
        end_scale = 1.1,
        spread_duration = 15,
        movement_slow_down_factor = 1,
    },
    trivial_smoke {
        name = "asteroid-smoke-tiberium-huge",
        color = { 0.22, 0.8, 0.1, 0.3 },
        affected_by_wind = false,
        render_layer = "elevated-object",
        duration = 140,
        start_scale = 1,
        end_scale = 1.4,
        fade_in_duration = 2,
        spread_duration = 20,
        movement_slow_down_factor = 1,
    },
})