minetest.override_item("default:steel_ingot", {
	description = "Iron Ingot"
})

minetest.register_craftitem("mk_items:iron_plate", {
	description = "Iron Plate",
	inventory_image = "mk_iron_plate.png"
})

minetest.register_craft({
	output = "mk_items:iron_plate 3",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"}
	}
})

minetest.register_craftitem("mk_items:iron_rod", {
	description = "Iron Rod",
	inventory_image = "mk_iron_rod.png"
})

minetest.register_craft({
	output = "mk_items:iron_rod 2",
	recipe = {
		{"default:steel_ingot"}
	}
})

minetest.register_craftitem("mk_items:iron_frame", {
	description = "Iron Frame",
	inventory_image = "mk_iron_frame.png"
})

minetest.register_craft({
	output = "mk_items:iron_frame 2",
	recipe = {
		{"mk_items:iron_rod", "mk_items:iron_rod", "mk_items:iron_rod"},
		{"mk_items:iron_rod", "", "mk_items:iron_rod"},
		{"mk_items:iron_rod", "mk_items:iron_rod", "mk_items:iron_rod"}
	}
})

minetest.register_craftitem("mk_items:copper_coil", {
	description = "Copper Coil",
	inventory_image = "mk_copper_coil.png"
})

minetest.register_craft({
	output = "mk_items:copper_coil 2",
	recipe = {
		{"default:copper_ingot"}
	}
})

minetest.register_craftitem("mk_items:power_supply", {
	description = "AC/DC Power Converter",
	inventory_image = "mk_power_supply.png"
})

minetest.register_craft({
	output = "mk_items:power_supply",
	recipe = {
		{"mk_items:iron_rod", "", "mk_items:iron_rod"},
		{"mk_items:copper_coil", "mk_items:iron_frame", "mk_items:copper_coil"},
		{"mk_items:iron_rod", "", "mk_items:iron_rod"}
	}
})

minetest.register_craftitem("mk_items:stator", {
	description = "Stator",
	inventory_image = "mk_stator.png"
})

minetest.register_craft({
	output = "mk_items:stator",
	recipe = {
		{"", "mk_items:steel_rod", ""},
		{"mk_items:iron_plate", "mk_items:copper_coil", "mk_items:iron_plate"},
		{"", "mk_items:steel_rod", ""}
	}
})

minetest.register_craftitem("mk_items:steel_ingot", {
	description = "Steel Ingot",
	inventory_image = "mk_steel_ingot.png"
})

minetest.register_craftitem("mk_items:steel_rod", {
	description = "Steel Rod",
	inventory_image = "mk_steel_rod.png"
})

minetest.register_craft({
	output = "mk_items:steel_rod 2",
	recipe = {
		{"mk_items:steel_ingot"}
	}
})