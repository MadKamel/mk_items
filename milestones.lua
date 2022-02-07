local mod_storage = minetest.get_mod_storage()

local achieve_milestone = function(m_num, set_milestone)
	local prog = mod_storage:get_int("milestone")
	if set_milestone then
		mod_storage:set_int("milestone", prog + 1)
	end
	if prog >= 0 then
		minetest.log("true")
		minetest.log(prog)

		minetest.register_craft({
			output = "mk_items:iron_rod 2",
			recipe = {
				{"default:steel_ingot"}
			}
		})
	end
	if prog >= 1 then

		minetest.register_craft({
			output = "mk_items:iron_plate 3",
			recipe = {
				{"default:steel_ingot", "default:steel_ingot"}
			}
		})
	end
	if prog >= 2 then

		minetest.register_craft({
			output = "mk_items:copper_coil 2",
			recipe = {
				{"default:copper_ingot"}
			}
		})

		minetest.register_craft({
			output = "mk_items:iron_frame 2",
			recipe = {
				{"mk_items:iron_rod", "mk_items:iron_rod", "mk_items:iron_rod"},
				{"mk_items:iron_rod", "", "mk_items:iron_rod"},
				{"mk_items:iron_rod", "mk_items:iron_rod", "mk_items:iron_rod"},
			}
		})
	end
	if prog >= 3 then

		minetest.register_craft({
			output = "mk_items:power_supply",
			recipe = {
				{"mk_items:iron_rod", "", "mk_items:iron_rod"},
				{"mk_items:copper_coil", "mk_items:iron_frame", "mk_items:copper_coil"},
				{"mk_items:iron_rod", "", "mk_items:iron_rod"},
			}
		})

		minetest.register_craft({
			output = "default:furnace",
			recipe = {
				{"mk_items:iron_plate", "mk_items:iron_plate", "mk_items:iron_plate"},
				{"mk_items:iron_rod", "mk_items:iron_frame", "mk_items:iron_rod"},
				{"mk_items:copper_coil", "mk_items:power_supply", "mk_items:copper_coil"},
			}
		})
	end
	if prog >= 4 then

		minetest.register_craft({
			output = "mk_items:coke_lump",
			type = "cooking",
			recipe = "default:coal_lump"
		})

		minetest.register_craft({
			output = "mk_items:coked_iron_lump",
			type = "shapeless",
			recipe = {"default:iron_lump", "mk_items:coke_lump"}
		})

		minetest.register_craft({
			output = "mk_items:steel_ingot",
			type = "cooking",
			recipe = "mk_items:coked_iron_lump"
		})

		minetest.register_craft({
			output = "mk_items:steel_rod 2",
			recipe = {
				{"mk_items:steel_ingot"}
			}
		})

		minetest.register_craft({
			output = "mk_items:steel_frame 2",
			recipe = {
				{"mk_items:steel_rod", "mk_items:steel_rod", "mk_items:steel_rod"},
				{"mk_items:steel_rod", "", "mk_items:steel_rod"},
				{"mk_items:steel_rod", "mk_items:steel_rod", "mk_items:steel_rod"},
			}
		})

	end
end

if mod_storage:get_int("milestone") then
	local prog = mod_storage:get_int("milestone")
	achieve_milestone(prog+1, false)
else
	mod_storage:set_int("milestone", 0)
end

-- Register milestone costs
milestones = {
	{
		ItemStack("mk_items:iron_rod 10")
	},
	{
		ItemStack("mk_items:iron_rod 20"),
		ItemStack("mk_items:iron_plate 10")
	},
	{
		ItemStack("mk_items:copper_coil 20"),
		ItemStack("mk_items:iron_frame 8")
	},
	{
		ItemStack("mk_items:power_supply 2"),
		ItemStack("mk_items:iron_frame 16")
	}
}

-- Determine if the node contains everything needed to achieve this milestone.
local input_is_valid = function(pos, m_num)
	local inv = minetest.get_meta(pos):get_inventory()
	minetest.log(dump(milestones[m_num+1]))
	if milestones[m_num+1] then
		for m_counter = 1, #milestones[m_num+1] do
			if inv:contains_item("container", milestones[m_num+1][m_counter]) then
				minetest.log("Item "..m_counter.." is correct.")
			else
				return false
			end
		end
	end
	return true
end



minetest.register_node("mk_items:milestone_terminal", {
	description = "Milestone Terminal",
	tiles = {"mk_foundation_floor.png", "mk_hub_terminal.png"},
	groups = {oddly_breakable_by_hand = 2},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("container", 1*8)
		meta:set_string("infotext", "Configure Milestones")
		local fs_content = "formspec_version[4]size[10.5,11]list[context;container;0.4,0.5;8,1;]list[current_player;main;0.4,2.6;8,1;]list[current_player;main;0.4,4;8,3;8]listring[context;container]button[3.7,1.7;3,0.7;send;Submit]"
		meta:set_string("formspec", fs_content)
	end,
	on_receive_fields = function(pos, formname, fields, player)
		minetest.log(dump(fields))
		if fields.send then
			if input_is_valid(pos, mod_storage:get_int("milestone")) then
				achieve_milestone(mod_storage:get_int("milestone")+1, true)
			end
		end
	end,
})