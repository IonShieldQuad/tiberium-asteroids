require("util")


local function asteroid_size(asteroid)
    local asteroid_sizes = { "chunk", "small", "medium", "big", "huge" }
    local shared_health = { 0, 200, 800, 4000, 10000 }
    local size = nil
    local sizei = nil
    for _, name in ipairs(asteroid_sizes) do
        if string.find(asteroid.name, name) then
            size = name
            sizei = _
        end
    end

    return size, sizei
end


script.on_event(defines.events.on_script_trigger_effect, function(event)
    if event.source_entity and event.source_entity.valid and event.source_entity.surface and event.source_entity.surface.valid then
        if event.effect_id == "ore-destruction-blue" or event.effect_id == "ore-destruction-all" or event.effect_id == "seed-launch" or "seed-launch-blue" then
            local missile = event.source_entity or {}


            local asteroids = missile.surface.find_entities_filtered {
                position = missile.position,
                radius = 3,
                type = "asteroid"
            }

            if event.effect_id == "ore-destruction-blue" or event.effect_id == "ore-destruction-all" then
                for _, asteroid in ipairs(asteroids) do
                    if asteroid.valid and string.find(asteroid.name, "tiberium") then
                        local size
                        local sizei
                        size, sizei = asteroid_size(asteroid)

                        if sizei and event.effect_id == "ore-destruction-blue" then
                            if sizei then
                                asteroid.surface.create_entity {
                                    name = "tiberium-asteroid-explosion-" .. tostring(sizei),
                                    position = asteroid.position
                                }
                            end
                            asteroid.destroy()
                        end
                        if sizei and event.effect_id == "ore-destruction-all" then
                            asteroid.die()
                        end
                    end
                end
            else
                for _, asteroid in ipairs(asteroids) do
                    if asteroid.valid and not string.find(asteroid.name, "tiberium") then
                        local size
                        local sizei
                        size, sizei = asteroid_size(asteroid)
                        local shared_health = { 0, 200, 800, 4000, 10000 }
                        if size and sizei and (event.effect_id == "seed-launch-blue" or (event.effect_id == "seed-launch" and math.random > 0.5)) then
                            asteroid.surface.create_entity {
                                name = "tiberium-asteroid-explosion-" .. tostring(sizei),
                                position = asteroid.position
                            }
                            asteroid.surface.create_entity {
                                name = tostring(size) .. "-tiberium-asteroid",
                                position = asteroid.position,
                                health = asteroid.get_health_ratio() * shared_health[sizei],
                                orientation = asteroid.orientation,
                                speed = asteroid.speed
                            }
                            asteroid.destroy()
                        end
                    end
                end
            end
        end
    end
end)

script.on_event(defines.events.on_entity_damaged, function(event)
    if event.entity.valid and event.entity.type == "asteroid" and not string.find(event.entity.name, "tiberium") then
        local asteroid = event.entity

        if asteroid and asteroid.valid and asteroid.surface.valid then
            local shared_health = { 0, 200, 800, 4000, 10000 }
            local size = nil
            local sizei = nil
            size, sizei = asteroid_size(asteroid)

            if asteroid.health <= 0 and event.damage_type == "tiberium" and math.random() > 0.75 then
                asteroid.surface.create_entity {
                    name = "tiberium-asteroid-chunk",
                    position = asteroid.position,
                    orientation = asteroid.orientation,
                    speed = asteroid.speed
                }
            end




            if event.source and (event.source.name == "tiberium-seed" or event.source.name == "tiberium-seed-h") then
                if sizei and math.random() > 0.5 then
                    asteroid.surface.create_entity {
                        name = "tiberium-asteroid-explosion-" .. tostring(sizei),
                        position = asteroid.position
                    }
                    asteroid.surface.create_entity {
                        name = tostring(size) .. "-tiberium-asteroid",
                        position = asteroid.position,
                        health = asteroid.get_health_ratio() * shared_health[sizei],
                        orientation = asteroid.orientation,
                        speed = asteroid.speed
                    }
                    asteroid.destroy()
                end
            elseif event.source and (event.source.name == "tiberium-seed-blue" or event.source.name == "tiberium-seed-blue-h") then
                if sizei then
                    asteroid.surface.create_entity {
                        name = "tiberium-asteroid-explosion-" .. tostring(sizei),
                        position = asteroid.position
                    }
                    asteroid.surface.create_entity {
                        name = tostring(size) .. "-tiberium-asteroid",
                        position = asteroid.position,
                        health = asteroid.get_health_ratio() * shared_health[sizei],
                        orientation = asteroid.orientation,
                        speed = asteroid.speed
                    }
                    asteroid.destroy()
                end
            end
        end
    end
    if event.entity.valid and event.entity.type == "asteroid" and string.find(event.entity.name, "tiberium") then
        local asteroid = event.entity

        --[[if (event.source or event.cause) then
            local other = event.source or event.cause
            if other and other.valid and other.type == "tile" then
                local tile = other
                local tank = asteroid.surface.create_entity{
                    name = "tib-dummy-storage-tank",
                    position = tile.position,
                    force = "neutral",
                    source = asteroid,
                    cause = asteroid
                }
                if tank then

                    tank.insert_fluid({ name = "liquid-tiberium", amount = event.original_damage_amount })

                    tank.die()
                end
            end
        end--]]

        --if asteroid and asteroid.valid and asteroid.surface.valid and not event.source then
        if asteroid and asteroid.valid and asteroid.surface.valid then
            local asteroid_sizes = { "chunk", "small", "medium", "big", "huge" }

            local size = nil
            local sizei = nil
            for _, name in ipairs(asteroid_sizes) do
                if string.find(asteroid.name, name) then
                    size = name
                    sizei = _
                end
            end




            if event.source and (event.source.name == "tiberium-catalyst-missile-all" or event.source.name == "tiberium-catalyst-missile-all-h") then
                asteroid.die()
            elseif event.source and (event.source.name == "tiberium-catalyst-missile-blue" or event.source.name == "tiberium-catalyst-missile-blue-h") then
                if sizei then
                    asteroid.surface.create_entity {
                        name = "tiberium-asteroid-explosion-" .. tostring(sizei),
                        position = asteroid.position
                    }
                end
                asteroid.destroy()
            else
                local tiles = nil
                local srf = 0
                local iter = 1
                tiles = asteroid.surface.find_tiles_filtered {
                    position = asteroid.position,
                    radius = 5,
                    name = "empty-space",
                    invert = true
                }
                srf = asteroid.surface.count_entities_filtered {
                    position = asteroid.position,
                    radius = 5,
                    name = "tiberium-srf-wall"
                }
                if #tiles == 0 then
                    iter = 2
                    tiles = asteroid.surface.find_tiles_filtered {
                        position = asteroid.position,
                        radius = 10,
                        name = "empty-space",
                        invert = true
                    }
                    srf = asteroid.surface.count_entities_filtered {
                        position = asteroid.position,
                        radius = 10,
                        name = "tiberium-srf-wall"
                    }
                end
                if #tiles == 0 then
                    iter = 3
                    tiles = asteroid.surface.find_tiles_filtered {
                        position = asteroid.position,
                        radius = 15,
                        name = "empty-space",
                        invert = true
                    }
                    srf = asteroid.surface.count_entities_filtered {
                        position = asteroid.position,
                        radius = 15,
                        name = "tiberium-srf-wall"
                    }
                end
                if #tiles > 0 and srf == 0 then
                    local tile = nil
                    while #tiles > 0 and (not tile or not tile.valid) do
                        local ntile = math.random(#tiles)
                        tile = tiles[ntile]
                        if not tile and tile.valid then
                            table.remove(tiles, ntile)
                        end
                    end

                    if tile and tile.valid then
                        local tank = asteroid.surface.create_entity {
                            name = "tib-dummy-storage-tank",
                            position = tile.position,
                            force = "neutral",
                            source = asteroid,
                            cause = asteroid
                        }
                        if tank then
                            tank.insert_fluid({
                                name = "liquid-tiberium",
                                amount = math.max(1,
                                    math.abs(event.final_damage_amount / iter))
                            })

                            tank.die()
                        end
                    end
                end
            end
        end
    end
end)


local ASTEROID_NAME = "huge-tiberium-asteroid"
local ASTEROID_SPRITE = "huge-tiberium-asteroid-fall"
local NODE_NAME = "tibGrowthNode"
local CONTAMINATION_RADIUS = 20

script.on_event(defines.events.on_player_selected_area, function(event)
    if event.item == "tiberium-asteroid-remote" then
        local player = game.players[event.player_index]
        if not (player.admin and player.cheat_mode) then
            player.print("Only admins in editor mode can use this remote.")
            return
        end

        local position = event.area.left_top
        local surface = player.surface

        player.print("Tiberium asteroid strike initiated...") -- t = 0s

        storage = storage or {}
        storage.strikes = storage.strikes or {}

        table.insert(storage.strikes, {
            position = position,
            surface = surface,
            initial_tick = event.tick,
            alert_tick = event.tick + 5 * 60, -- 5 seconds
            spawn_tick = event.tick + 8 * 60, -- 8 sceonds
            end_tick = event.tick + 30 * 60   -- 12 seconds

        })

        --[[ t = 5s : Message d'alerte
      surface.create_entity {
            name = "flying-text",
            position = position,
            text = { "", "[color=red]A massive asteroid is entering the atmosphere![/color]" },
            color = { r = 1, g = 0.3, b = 0.1 }
        }--]]

        -- t = 8s : Simulation d'animation de descente (sprite + animation simplifiée)
        --[[local sprite_id = rendering.draw_sprite {
            sprite = ASTEROID_SPRITE,
            surface = surface,
            target = { position.x, position.y - 30 }, -- Commence plus haut
            target_offset = { 0, 0 },
            x_scale = 2,
            y_scale = 2,
            render_layer = "object",
        }--]]

        local ticks_to_fall = 60 -- ~2s d'animation (60 ticks)
        local tick_start = game.tick

        --[[script.on_nth_tick(1, function(tick_event)
            local ticks_elapsed = game.tick - tick_start
            if sprite_id.valid then
                local y = position.y - 30 + (30 * (ticks_elapsed / ticks_to_fall))
                rendering.set_target(sprite_id, { position.x, y })
            end

            if ticks_elapsed >= ticks_to_fall then
                rendering.destroy(sprite_id)

                -- Impact (t = 10s)
                surface.create_entity { name = "big-explosion", position = position }
                surface.create_entity { name = NODE_NAME, position = position, force = "neutral" }

                -- Génère une zone contaminée (optionnel : tuiles ou entités)
                for x = -CONTAMINATION_RADIUS, CONTAMINATION_RADIUS do
                    for y = -CONTAMINATION_RADIUS, CONTAMINATION_RADIUS do
                        local dist = math.sqrt(x * x + y * y)
                        if dist <= CONTAMINATION_RADIUS then
                            local pos = { x = position.x + x, y = position.y + y }
                            surface.create_entity { name = "tiberium-contamination", position = pos, force = "neutral" }
                        end
                    end
                end

                script.on_nth_tick(1, nil) -- désactiver l'animation
            end
        end)--]]
    end
end)

script.on_event(defines.events.on_tick, function(event)
    storage = storage or {}
    storage.strikes = storage.strikes or {}
    tick = event.tick
    for _, strike in pairs(storage.strikes) do
        local surface = strike.surface
        local position = strike.position
        if tick == strike.alert_tick then
            --t = 5s : Message d'alerte
            for _, player in pairs(game.connected_players) do
                if player.valid and player.surface == surface then
                    player.create_local_flying_text({
                        position = player.position,
                        text = { "", "[color=red]A massive asteroid is enteng the atmosphere![/color]" },
                        color = { r = 1, g = 0.3, b = 0.1 },
                        time_to_live = 300,
                        speed = 1 / 60
                    })
                end
            end
        end

        local ticks_to_fall = strike.end_tick - strike.spawn_tick
        local speed_y = 0.3
        local speed_x = 0.1
        local accel_x = -speed_x / ticks_to_fall
        if tick == strike.spawn_tick then
            -- t = 8s : Simulation d'animation de descente (sprite + animation simplifiée)
            strike.sprite_id = rendering.draw_sprite {
                sprite = ASTEROID_SPRITE,
                surface = surface,
                target = { x = position.x + speed_x * ticks_to_fall + accel_x * ticks_to_fall ^ 2 / 2, y = position.y - ticks_to_fall * speed_y }, -- Commence plus haut
                target_offset = { 0, 0 },
                x_scale = 1,
                y_scale = 1,
                render_layer = "object",
                visible = true
            }
            strike.light = rendering.draw_light {
                target = { x = position.x + speed_x * ticks_to_fall + accel_x * ticks_to_fall ^ 2 / 2, y = position.y - ticks_to_fall * speed_y },
                sprite = "utility/light_medium",
                surface = strike.sprite_id.surface,
                position = { x = position.x + speed_x * ticks_to_fall + accel_x * ticks_to_fall ^ 2 / 2, y = position.y - ticks_to_fall * speed_y },
                intensity = 10,
                scale = 10,
                color = { 0, 1, 0 },
                visible = true
            }



            surface.play_sound {
                path = "tiberium-asteroid-reentry",
                --position = { x = position.x, y = position.y },
                volume_modifier = 1,
            }
        end
        if tick > strike.spawn_tick and tick < strike.end_tick then
            local ticks_elapsed = tick - strike.spawn_tick
            if strike.sprite_id.valid then
                local y = position.y - (speed_y * (ticks_to_fall - ticks_elapsed))
                local x = position.x + speed_x * (ticks_to_fall - ticks_elapsed) +
                    accel_x * (ticks_to_fall - ticks_elapsed) ^ 2 / 2
                strike.sprite_id.target = { x = x, y = y }
            end
            if strike.light.valid then
                local y = position.y - (speed_y * (ticks_to_fall - ticks_elapsed))
                local x = position.x + speed_x * (ticks_to_fall - ticks_elapsed) +
                    accel_x * (ticks_to_fall - ticks_elapsed) ^ 2 / 2
                strike.light.target = { x = x, y = y }
            end
        end

        if tick >= strike.end_tick then
            if strike.sprite_id.valid then
                strike.sprite_id.destroy()
            end
            if strike.light.valid then
                strike.light.destroy()
            end
            -- Impact (t = 12)
            surface.create_entity { name = "big-explosion", position = position }
            surface.create_entity { name = NODE_NAME, position = position, force = "neutral", amount = 1e6, raise_built = true }


            -- Génère une zone contaminée (optionnel : tuiles ou entités)
            --[[for x = -CONTAMINATION_RADIUS, CONTAMINATION_RADIUS do
                for y = -CONTAMINATION_RADIUS, CONTAMINATION_RADIUS do
                    local dist = math.sqrt(x * x + y * y)
                    if dist <= CONTAMINATION_RADIUS then
                        local pos = { x = position.x + x, y = position.y + y                    if surface.count_entities_filtered { position = pos, name = NODE_NAME } == 0 then
                            surface.create_entity { name = "tiberium-ore", position = pos, force = "neutral", amount = 100 * settings.startup["tiberium-growth"].value }
                        end
                    end
                end
            end--]]

            local locations = {
                { x = position.x, y = position.y }
            }


            local locations2 = {}
            local l2num = math.random(4, 8)


            for i = 1, 100, 1 do
                if #locations2 < l2num then
                    local angle = math.random() * 2 * math.pi
                    local radius = math.random(CONTAMINATION_RADIUS, CONTAMINATION_RADIUS + 6)
                    local x = position.x + math.cos(angle) * radius
                    local y = position.y + math.sin(angle) * radius
                    local pos = { x = x, y = y }
                    if surface.count_tiles_filtered { position = pos, name = "empty-space", invert = true } then
                        table.insert(locations2, pos)
                    end
                end
                --surface.create_entity { name = NODE_NAME, position = { x = x, y = y }, force = "neutral", amount = 1e5, raise_built = true }
            end

            local locations3 = {}
            local l3num = math.random(4, 8)


            for i = 1, 100, 1 do
                if #locations3 < l3num then
                    local angle = math.random() * 2 * math.pi
                    local radius = math.random(CONTAMINATION_RADIUS / 2, CONTAMINATION_RADIUS / 2 + 6)
                    local x = position.x + math.cos(angle) * radius
                    local y = position.y + math.sin(angle) * radius
                    local pos = { x = x, y = y }
                    if surface.count_tiles_filtered { position = pos, name = "empty-space", invert = true } then
                        table.insert(locations3, pos)
                    end
                end
                --surface.create_entity { name = NODE_NAME, position = { x = x, y = y }, force = "neutral", amount = 1e5, raise_built = true }
            end

            for _, value in ipairs(locations2) do
                table.insert(locations, value)
            end
            for _, value in ipairs(locations3) do
                table.insert(locations, value)
            end


            for _, pos in ipairs(locations) do
                surface.create_entity { name = NODE_NAME, position = pos, force = "neutral", amount = _ == 1 and 1e6 or 1e5, raise_built = true }
                local tank = surface.create_entity {
                    name = "tib-dummy-storage-tank",
                    position = pos,
                    force = "neutral",
                }
                if tank then
                    tank.insert_fluid({
                        name = "liquid-tiberium",
                        amount = 1e6
                    })

                    tank.die()
                end
                if surface.count_entities_filtered { position = pos, name = NODE_NAME } == 0 then
                    surface.create_entity { name = NODE_NAME, position = pos, force = "neutral", amount = _ == 1 and 1e6 or 1e5, raise_built = true }
                end
            end




            storage.strikes[_] = nil
        end
    end
end)
