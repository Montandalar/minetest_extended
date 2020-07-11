minetest.register_craftitem("gems_ruby:ruby", {
	description = "Ruby",
	inventory_image = "ruby_crystal.png",
})


minetest.register_node("gems_ruby:ruby_ore", {
	description = "Ruby Ore",
	tiles = {"default_stone.png^ruby_ore.png"},
	groups = {cracky=3, stone=1},
    drop = {
        items = {
            {
                rarity = 1,
                items = {"gems_ruby:ruby 2"},
            },
            {
                rarity = 2,
                items = {"gems_ruby:ruby"},
            },
            {
                rarity = 4,
                items = {"gems_ruby:ruby 3"},
            }
        }
    },
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "gems_ruby:ruby_ore",
	wherein = "default:stone",
	clust_scarcity = 10*10*10,
	clust_num_ores = 6,
	clust_size = 3,
	y_min = -31000,
	y_max = -64,
})


minetest.register_node("gems_ruby:block", {
	description = "Ruby Block",
	tiles = {"ruby_block.png"},
	groups = {cracky=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "gems_ruby:block",
	recipe = {
		{"gems_ruby:ruby", "gems_ruby:ruby"},
		{"gems_ruby:ruby", "gems_ruby:ruby"}
	}
})


stairs.register_stair_and_slab("rubyblock", "gems_ruby:block",
	{cracky=3, oddly_breakable_by_hand=1},
	{"ruby_block.png"},
	"Ruby Stair",
	"Ruby Slab",
	default.node_sound_glass_defaults()
)