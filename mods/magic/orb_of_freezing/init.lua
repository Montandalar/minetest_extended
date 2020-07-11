minetest.register_craftitem("orb_of_freezing:orb_of_freezing", {
    description = "Orb of Freezing\nMana: 10",
    inventory_image = "orb_of_freezing_orb.png",
    on_use = function(itemstack, player, pointed_thing)
        local name = player:get_player_name()
        local players_mana = hbmana.get(name)

        if players_mana > 10 then
            hbmana.set(name, players_mana - 10)

            local player_pos = player:get_pos()
            local pointed_pos = pointed_thing.under
            local dir = player:get_look_dir()

            obj = minetest.add_entity({
                x = player_pos.x,
                y = player_pos.y + 1.5,
                z = player_pos.z
            }, "orb_of_freezing:icicle")

            obj:set_rotation({
                x = -player:get_look_vertical(),
                y = player:get_look_horizontal(),
                z = 0
            })

            obj:setvelocity({
                x = dir.x * 30,
                y = dir.y * 30,
                z = dir.z * 30
            })
        end
    end
})

minetest.register_craft({
	output = "orb_of_freezing:orb_of_freezing",
	recipe = {
		{"", "default:glass", ""},
		{"default:glass", "gems_sapphire:sapphire", "default:glass"},
		{"", "default:glass", ""},
	}
})

minetest.register_entity("orb_of_freezing:icicle", {
    physical = false,
    visual = "mesh",
    mesh = "orb_of_freezing_icicle.obj",
    textures = {"orb_of_freezing_icicle.png"},
    collisionbox = {-0.1,-0.1,-0.1,0.1,0.1,0.1},
    timer = 0,
    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        local pos = self.object:get_pos()

        pos = vector.round(pos)
        local node = minetest.get_node(pos)

        if node.name ~= "air" then
            if node.name == "default:water_source" or
            node.name == "default:water_flowing" or
            node.name == "default:river_water_source" or
            node.name == "default:river_water_flowing" then
                minetest.chat_send_all("Víz!")
                minetest.place_node(pos, {name="default:ice"})
            end
            self.object:remove()
        end

        minetest.add_particlespawner({
            amount = 10,
            time = 0.10,
            minpos = {
                x = pos.x - 0.1,
                y = pos.y - 0.1,
                z = pos.z - 0.1
            },
            maxpos = {
                x = pos.x + 0.1,
                y = pos.y + 0.1,
                z = pos.z + 0.1
            },
            minexptime = 0.1,
            maxexptime = 0.2,
            minsize = 0.50,
            maxsize = 0.50,
            collisiondetection = false,
            vertical = false,
            texture = "orb_of_freezing_particle.png",
        })

        if self.timer > 0.2 then
            local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
            for k, obj in pairs(objs) do
                if obj:get_luaentity() ~= nil then
                    if obj:get_luaentity().name ~= "orb_of_freezing:icicle" and obj:get_luaentity().name ~= "__builtin:item" then
                        obj:punch(self.object, 1.0, {
                            full_punch_interval = 1.0,
                            damage_groups = {fleshy = 3},
                        }, nil)

                        self.object:remove()
                    end
                elseif obj:is_player() then
                    obj:punch(self.object, 1.0, {
                        full_punch_interval = 1.0,
                        damage_groups = {fleshy = 3},
                    }, nil)
                    self.object:remove()
                end
            end
            self.timer = 0
        end
    end
})
