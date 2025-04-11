local tiber = data.raw["planet"].tiber

tiber.asteroid_spawn_definitions = {
    {
        angle_when_stopped = 1,
        asteroid = "metallic-asteroid-chunk",
        probability = 0.0125,
        speed = 0.016666666666666665,
        type = "asteroid-chunk"
    },
    {
        angle_when_stopped = 1,
        asteroid = "carbonic-asteroid-chunk",
        probability = 0.0083333333333333321,
        speed = 0.016666666666666665,
        type = "asteroid-chunk"
    },
    {
        angle_when_stopped = 1,
        asteroid = "oxide-asteroid-chunk",
        probability = 0.0041666666666666661,
        speed = 0.016666666666666665,
        type = "asteroid-chunk"
    },
    {
        angle_when_stopped = 1,
        asteroid = "tiberium-asteroid-chunk",
        probability = 0.03,
        speed = 0.016666666666666665,
        type = "asteroid-chunk"
    }
}


for name, conn in pairs(data.raw["space-connection"]) do
    if conn.from == "tiber" or conn.to == "tiber" then
        local point1 = conn.from == "tiber" and 0.1 or 0.9
        local point2 = conn.from == "tiber" and 0.5 or 0.5
        local point3 = conn.from == "tiber" and 0.9 or 0.1

        table.insert(conn.asteroid_spawn_definitions, {
            asteroid = "tiberium-asteroid-chunk",
            spawn_points = {
                {
                    angle_when_stopped = 0.6,
                    distance = point1,
                    probability = 0.04,
                    speed = 0.016666666666666665
                },
                {
                    angle_when_stopped = 0.6,
                    distance = point2,
                    probability = 0.1,
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
                        probability = 0.05,
                        speed = 0.016666666666666665
                    },
                    {
                        angle_when_stopped = 0.6,
                        distance = point2,
                        probability = 0.05,
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
                    probability = 0.0,
                    speed = 0.016666666666666665
                },
                {
                    angle_when_stopped = 0.6,
                    distance = point2,
                    probability = 0.025,
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
                    probability = 0.0,
                    speed = 0.016666666666666665
                },
                {
                    angle_when_stopped = 0.6,
                    distance = point2,
                    probability = 0.001,
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
