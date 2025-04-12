local tiber = data.raw["planet"].tiber

tiber.asteroid_spawn_definitions = {
    {
        angle_when_stopped = 1,
        asteroid = "metallic-asteroid-chunk",
        probability = 0.0125 / 2,
        speed = 0.016666666666666665,
        type = "asteroid-chunk"
    },
    {
        angle_when_stopped = 1,
        asteroid = "carbonic-asteroid-chunk",
        probability = 0.0083333333333333321 / 2,
        speed = 0.016666666666666665,
        type = "asteroid-chunk"
    },
    {
        angle_when_stopped = 1,
        asteroid = "oxide-asteroid-chunk",
        probability = 0.0041666666666666661 / 2,
        speed = 0.016666666666666665,
        type = "asteroid-chunk"
    },
    {
        angle_when_stopped = 1,
        asteroid = "tiberium-asteroid-chunk",
        probability = 0.0125 / 2 + 0.0083333333333333321 / 2 + 0.0041666666666666661 / 2,
        speed = 0.016666666666666665,
        type = "asteroid-chunk"
    },
    {
        angle_when_stopped = 1,
        asteroid = "small-tiberium-asteroid",
        probability = (0.0125 / 2 + 0.0083333333333333321 / 2 + 0.0041666666666666661 / 2) / 3,
        speed = 0.016666666666666665,
    }
}


for name, conn in pairs(data.raw["space-connection"]) do
    if conn.from == "tiber" or conn.to == "tiber" then
        local point1 = conn.from == "tiber" and 0.1 or 0.9
        local point2 = conn.from == "tiber" and 0.5 or 0.5
        local point3 = conn.from == "tiber" and 0.9 or 0.1

        local replace = { 0.5, 0.5, 0.5, 0.5, 0.5 }
        local add = { 0.5, 0.2, 0.05, 0.005, 0.0 }

        local chunk_p1 = 0
        local small_p1 = 0
        local medium_p1 = 0
        local big_p1 = 0
        local huge_p1 = 0

        local total_p1 = 0

        local chunk_p2 = 0
        local small_p2 = 0
        local medium_p2 = 0
        local big_p2 = 0
        local huge_p2 = 0

        local total_p2 = 0

        for _, d in ipairs(conn.asteroid_spawn_definitions) do
            if string.find(d.asteroid, "chunk") then
                for _, p in ipairs(d.spawn_points) do
                    if (p.distance == point1) then
                        chunk_p1 = chunk_p1 + p.probability
                        total_p1 = total_p1 + p.probability
                    end
                    if (p.distance == point2) then
                        chunk_p2 = chunk_p2 + p.probability
                        total_p2 = total_p2 + p.probability
                    end
                end
            elseif string.find(d.asteroid, "small") then
                for _, p in ipairs(d.spawn_points) do
                    if (p.distance == point1) then
                        small_p1 = small_p1 + p.probability
                        total_p1 = total_p1 + p.probability
                    end
                    if (p.distance == point2) then
                        small_p2 = small_p2 + p.probability
                        total_p2 = total_p2 + p.probability
                    end
                end
            elseif string.find(d.asteroid, "medium") then
                for _, p in ipairs(d.spawn_points) do
                    if (p.distance == point1) then
                        medium_p1 = medium_p1 + p.probability
                        total_p1 = total_p1 + p.probability
                    end
                    if (p.distance == point2) then
                        medium_p2 = medium_p2 + p.probability
                        total_p2 = total_p2 + p.probability
                    end
                end
            elseif string.find(d.asteroid, "big") then
                for _, p in ipairs(d.spawn_points) do
                    if (p.distance == point1) then
                        big_p1 = big_p1 + p.probability
                        total_p1 = total_p1 + p.probability
                    end
                    if (p.distance == point2) then
                        big_p2 = big_p2 + p.probability
                        total_p2 = total_p2 + p.probability
                    end
                end
            elseif string.find(d.asteroid, "huge") then
                for _, p in ipairs(d.spawn_points) do
                    if (p.distance == point1) then
                        huge_p1 = huge_p1 + p.probability
                        total_p1 = total_p1 + p.probability
                    end
                    if (p.distance == point2) then
                        huge_p2 = huge_p2 + p.probability
                        total_p2 = total_p2 + p.probability
                    end
                end
            end
        end




        for _, d in ipairs(conn.asteroid_spawn_definitions) do
            if string.find(d.asteroid, "chunk") then
                for _, p in ipairs(d.spawn_points) do
                    if (p.distance == point1) then
                        p.probability = p.probability * (1 - replace[1])
                    end
                    if (p.distance == point2) then
                        p.probability = p.probability * (1 - replace[1])
                    end
                end
            elseif string.find(d.asteroid, "small") then
                for _, p in ipairs(d.spawn_points) do
                    if (p.distance == point1) then
                        p.probability = p.probability * (1 - replace[2])
                    end
                    if (p.distance == point2) then
                        p.probability = p.probability * (1 - replace[2])
                    end
                end
            elseif string.find(d.asteroid, "medium") then
                for _, p in ipairs(d.spawn_points) do
                    if (p.distance == point1) then
                        p.probability = p.probability * (1 - replace[3])
                    end
                    if (p.distance == point2) then
                        p.probability = p.probability * (1 - replace[3])
                    end
                end
            elseif string.find(d.asteroid, "big") then
                for _, p in ipairs(d.spawn_points) do
                    if (p.distance == point1) then
                        p.probability = p.probability * (1 - replace[4])
                    end
                    if (p.distance == point2) then
                        p.probability = p.probability * (1 - replace[4])
                    end
                end
            elseif string.find(d.asteroid, "huge") then
                for _, p in ipairs(d.spawn_points) do
                    if (p.distance == point1) then
                        p.probability = p.probability * (1 - replace[5])
                    end
                    if (p.distance == point2) then
                        p.probability = p.probability * (1 - replace[5])
                    end
                end
            end
        end



        table.insert(conn.asteroid_spawn_definitions, {
            asteroid = "tiberium-asteroid-chunk",
            spawn_points = {
                {
                    angle_when_stopped = 0.6,
                    distance = point1,
                    probability = chunk_p1 * replace[1] + total_p1 * add[1],
                    speed = 0.016666666666666665
                },
                {
                    angle_when_stopped = 0.6,
                    distance = point2,
                    probability = chunk_p2 * replace[1] + total_p2 * add[1],
                    speed = 0.016666666666666665
                },
                {
                    angle_when_stopped = 0.6,
                    distance = point3,
                    probability = 0,
                    speed = 0.016666666666666665
                }
            },
            type = "asteroid-chunk"
        })

        table.insert(conn.asteroid_spawn_definitions,
            {
                asteroid = "small-tiberium-asteroid",
                spawn_points = {
                    {
                        angle_when_stopped = 0.6,
                        distance = point1,
                        probability = small_p1 * replace[2] + total_p1 * add[2],
                        speed = 0.016666666666666665
                    },
                    {
                        angle_when_stopped = 0.6,
                        distance = point2,
                        probability = small_p2 * replace[2] + total_p2 * add[2],
                        speed = 0.016666666666666665
                    },
                    {
                        angle_when_stopped = 0.6,
                        distance = point3,
                        probability = 0,
                        speed = 0.016666666666666665
                    }
                }
            })
        table.insert(conn.asteroid_spawn_definitions, {
            asteroid = "medium-tiberium-asteroid",
            spawn_points = {
                {
                    angle_when_stopped = 0.6,
                    distance = point1,
                    probability = medium_p1 * replace[3] + total_p1 * add[3],
                    speed = 0.016666666666666665
                },
                {
                    angle_when_stopped = 0.6,
                    distance = point2,
                    probability = medium_p2 * replace[3] + total_p2 * add[3],
                    speed = 0.016666666666666665
                },
                {
                    angle_when_stopped = 0.6,
                    distance = point3,
                    probability = 0,
                    speed = 0.016666666666666665
                }
            }
        })
        table.insert(conn.asteroid_spawn_definitions, {
            asteroid = "big-tiberium-asteroid",
            spawn_points = {
                {
                    angle_when_stopped = 0.6,
                    distance = point1,
                    probability = big_p1 * replace[4] + total_p1 * add[4],
                    speed = 0.016666666666666665
                },
                {
                    angle_when_stopped = 0.6,
                    distance = point2,
                    probability = big_p2 * replace[4] + total_p2 * add[4],
                    speed = 0.016666666666666665
                },
                {
                    angle_when_stopped = 0.6,
                    distance = point3,
                    probability = 0,
                    speed = 0.016666666666666665
                }
            }
        })

        if huge_p1 + huge_p1 > 0 then
            table.insert(conn.asteroid_spawn_definitions, {
                asteroid = "huge-tiberium-asteroid",
                spawn_points = {
                    {
                        angle_when_stopped = 0.6,
                        distance = point1,
                        probability = huge_p1 * replace[5] + total_p1 * add[5],
                        speed = 0.016666666666666665
                    },
                    {
                        angle_when_stopped = 0.6,
                        distance = point2,
                        probability = huge_p2 * replace[5] + total_p2 * add[5],
                        speed = 0.016666666666666665
                    },
                    {
                        angle_when_stopped = 0.6,
                        distance = point3,
                        probability = 0,
                        speed = 0.016666666666666665
                    }
                }
            })
        end
    end
end
