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

minetest.register_craft({
	output = "mk_items:steel_ingot",
	type = "cooking",
	recipe = "mk_items:coked_iron_lump"
})

minetest.register_craftitem("mk_items:coke_lump", {
	description = "Coke Lump",
	inventory_image = "mk_coke.png"
})

minetest.register_craft({
	output = "mk_items:coke_lump",
	type = "cooking",
	recipe = "default:coal_lump"
})

minetest.register_craftitem("mk_items:coked_iron_lump", {
	description = "Coked Iron Lump",
	inventory_image = "mk_coked_iron.png"
})

minetest.register_craft({
	output = "mk_items:coked_iron_lump",
	type = "shapeless",
	recipe = {"default:iron_lump", "mk_items:coke_lump"}
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

minetest.register_craftitem("mk_items:framed_iron_plate", {
	description = "Framed Iron Plate",
	inventory_image = "mk_framed_iron_plate.png"
})

minetest.register_craft({
	output = "mk_items:framed_iron_plate 4",
	recipe = {
		{"", "mk_items:iron_plate", ""},
		{"mk_items:iron_plate", "mk_items:iron_frame", "mk_items:iron_plate"},
		{"", "mk_items:iron_plate", ""}
	}
})

minetest.register_craftitem("mk_items:motor_assembly", {
	description = "Motor Casing Assembly",
	inventory_image = "mk_motor_assembly.png"
})

minetest.register_craft({
	output = "mk_items:motor_assembly",
	recipe = {
		{"", "mk_items:iron_plate", ""},
		{"mk_items:framed_iron_plate", "mk_items:steel_rod", "mk_items:framed_iron_plate"},
		{"", "mk_items:iron_plate", ""}
	}
})

minetest.register_craftitem("mk_items:motor", {
	description = "Motor",
	inventory_image = "mk_motor.png"
})

minetest.register_craft({
	output = "mk_items:motor",
	recipe = {
		{"", "mk_items:power_supply", ""},
		{"mk_items:steel_rod", "mk_items:stator", "mk_items:steel_rod"},
		{"", "mk_items:motor_assembly", ""}
	}
})

minetest.register_node("mk_items:modular_motor", {
	description = "Modular Motor",
	tiles = {"mk_modular_motor_side.png", "mk_modular_motor_side.png", "mk_modular_motor_end.png", "mk_modular_motor_end.png", "mk_modular_motor_side.png", "mk_modular_motor_side.png"},
	groups = {oddly_breakable_by_hand = 3}
})

minetest.register_craft({
	output = "mk_items:modular_motor",
	recipe = {
		{"", "mk_items:framed_iron_plate", ""},
		{"mk_items:framed_iron_plate", "mk_items:motor", "mk_items:framed_iron_plate"},
		{"", "mk_items:framed_iron_plate", ""}
	}
})