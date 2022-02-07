dofile(minetest.get_modpath("mk_items").."/conveyor.lua")
dofile(minetest.get_modpath("mk_items").."/miner.lua")



-- First off, the chisel.
minetest.register_tool("mk_items:chisel", {
	description = "Mineral Deposit Chisel",
	inventory_image = "chisel.png",
	wield_image = "chisel.png^[transformR90",
	range = 2,
	tool_capabilities = {
		groupcaps={
			deposit = {
				times = {
					[1] = 1.60
				},
				uses = 0
			},
		},
		full_punch_interval = 0.01,
		max_drop_level = 1,
	}
})

give_chisel = function(player)
	local inv = player:get_inventory()
	inv:add_item("main", ItemStack("mk_items:chisel"))
	inv:add_item("main", ItemStack("default:furnace"))
	inv:add_item("main", ItemStack("mk_items:milestone_terminal"))
	if minetest.get_modpath("xenozapper") then
		inv:add_item("main", ItemStack("xenozapper:zapper"))
	end
end

-- Add the chisel to the player inventory upon first joining.
minetest.register_on_newplayer(give_chisel)



-- And the resource nodes.
minetest.register_node("mk_items:iron_deposit", {
	description = "Iron Mineral Deposit",
	tiles = {"mk_iron_node.png"},
	groups = {deposit = 1, cracky = 2},
	drop = "default:iron_lump",
	node_dig_prediction = "mk_items:iron_deposit",
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.set_node(pos, {name="mk_items:iron_deposit"})
	end
})

minetest.register_node("mk_items:copper_deposit", {
	description = "Copper Mineral Deposit",
	tiles = {"mk_copper_node.png"},
	groups = {deposit = 1, cracky = 2},
	drop = "default:copper_lump",
	node_dig_prediction = "mk_items:copper_deposit",
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.set_node(pos, {name="mk_items:copper_deposit"})
	end
})

minetest.register_node("mk_items:coal_deposit", {
	description = "Coal Mineral Deposit",
	tiles = {"mk_coal_node.png"},
	groups = {deposit = 1, cracky = 2},
	drop = "default:coal_lump",
	node_dig_prediction = "mk_items:coal_deposit",
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		minetest.set_node(pos, {name="mk_items:coal_deposit"})
	end
})

minetest.register_decoration({
	name = "mk_items:iron_deposit",
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt_with_snow", "default:dry_dirt_with_dry_grass"},
	sidelen = 16,
	fill_ratio = 0.0005,
	y_max = 64,
	y_min = 3,
	schematic = minetest.get_modpath("mk_items") .. "/schematics/iron_deposit.mts",
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})

minetest.register_decoration({
	name = "mk_items:copper_deposit",
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt_with_snow", "default:dry_dirt_with_dry_grass"},
	sidelen = 16,
	fill_ratio = 0.0005,
	y_max = 64,
	y_min = 8,
	schematic = minetest.get_modpath("mk_items") .. "/schematics/copper_deposit.mts",
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})

minetest.register_decoration({
	name = "mk_items:coal_deposit",
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt_with_snow", "default:dry_dirt_with_dry_grass"},
	sidelen = 16,
	fill_ratio = 0.00025,
	y_max = 64,
	y_min = 8,
	schematic = minetest.get_modpath("mk_items") .. "/schematics/coal_deposit.mts",
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})



-- Finally, the craftitems and other crafting recipes.
minetest.override_item("default:furnace", {
	groups = {oddly_breakable_by_hand = 3}
})

minetest.override_item("default:steel_ingot", {
	description = "Iron Ingot"
})

minetest.register_craftitem("mk_items:iron_plate", {
	description = "Iron Plate",
	inventory_image = "mk_iron_plate.png"
})

minetest.register_craftitem("mk_items:iron_rod", {
	description = "Iron Rod",
	inventory_image = "mk_iron_rod.png"
})

minetest.register_craftitem("mk_items:iron_frame", {
	description = "Iron Frame",
	inventory_image = "mk_iron_frame.png"
})

minetest.register_craftitem("mk_items:copper_coil", {
	description = "Copper Coil",
	inventory_image = "mk_copper_coil.png"
})

minetest.register_craftitem("mk_items:power_supply", {
	description = "AC/DC Power Converter",
	inventory_image = "mk_power_supply.png"
})

minetest.register_craftitem("mk_items:stator", {
	description = "Stator",
	inventory_image = "mk_stator.png"
})

minetest.register_craftitem("mk_items:steel_ingot", {
	description = "Steel Ingot",
	inventory_image = "mk_steel_ingot.png"
})

minetest.register_craftitem("mk_items:coke_lump", {
	description = "Coke Lump",
	inventory_image = "mk_coke.png"
})

minetest.register_craftitem("mk_items:coked_iron_lump", {
	description = "Coked Iron Lump",
	inventory_image = "mk_coked_iron.png"
})

minetest.register_craftitem("mk_items:steel_rod", {
	description = "Steel Rod",
	inventory_image = "mk_steel_rod.png"
})

minetest.register_craftitem("mk_items:framed_iron_plate", {
	description = "Framed Iron Plate",
	inventory_image = "mk_framed_iron_plate.png"
})

minetest.register_craftitem("mk_items:motor_assembly", {
	description = "Motor Casing Assembly",
	inventory_image = "mk_motor_assembly.png"
})

minetest.register_craftitem("mk_items:motor", {
	description = "Motor",
	inventory_image = "mk_motor.png"
})

minetest.register_node("mk_items:modular_motor", {
	description = "Modular Motor",
	tiles = {"mk_modular_motor_side.png", "mk_modular_motor_side.png", "mk_modular_motor_end.png", "mk_modular_motor_end.png", "mk_modular_motor_side.png", "mk_modular_motor_side.png"},
	groups = {oddly_breakable_by_hand = 3}
})

minetest.register_node("mk_items:foundation", {
	description = "Metal Foundation",
	tiles = {"mk_foundation_floor.png", "mk_foundation_wall.png"},
	groups = {oddly_breakable_by_hand = 3}
})



dofile(minetest.get_modpath("mk_items").."/milestones.lua")