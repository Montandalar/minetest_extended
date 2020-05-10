farming.register_plant("farming:peanut", {
	description = "Peanut Seed",
	inventory_image = "farming_peanut_seed.png",
	steps = 4,
	minlight = 10,
	fertility = {"grassland"},
})

-- Override drop
minetest.override_item("farming:peanut_4", {
    drop = "farming:peanut 5"
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:seed_peanut",
    recipe = {"farming:peanut", "bucket:bucket_water"},
    replacements = {
        {"bucket:bucket_water", "bucket:bucket_empty"}
    }
})

-- make peanut eatable
minetest.override_item("farming:peanut", {
    on_use = minetest.item_eat(0.5),
})