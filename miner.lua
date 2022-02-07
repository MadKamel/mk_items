function under(pos)
	pos_duplicate = pos
	pos_duplicate.y = pos_duplicate.y - 1
	return pos_duplicate
end

function above(pos)
	pos_duplicate = pos
	pos_duplicate.y = pos_duplicate.y + 1
	return pos_duplicate
end
	
local function update_meta(meta, enabled)
	local state = enabled and "on" or "off"
	meta:set_int("enabled", enabled and 1 or 0)
	local fs = "formspec_version[4]size[10.5,11]list[current_player;main;0.4,5.9;8,4;0]list[context;dst;0.4,4.6;1,1;0]"
	meta:set_string("formspec",fs)
	local output = meta:get_inventory():get_stack("dst", 1)
	if output:is_empty() then -- doesn't matter if paused or not
		meta:set_string("infotext", "Portable Miner")
		return false
	end
	return enabled
end


-- Register the Portable Miner
minetest.register_node("mk_items:miner", {
	description = "Portable Miner",
	tiles = {
		"mk_pminer_top.png",
		"mk_pminer_bottom.png",
		"mk_pminer_side.png"
	},
	groups = {oddly_breakable_by_hand = 3, falling_node = 1},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("dst", 1)
		update_meta(meta, false)
	end,
	max_stack = 1
})



minetest.register_abm({
	label = "Activate Miners",
	nodenames = {"mk_items:miner"},
	interval = 1,
	chance = 1,
	action = function(pos, node, aoc, aoc_wide)
		if minetest.get_node(under(pos)).name == "mk_items:iron_deposit" then
			minetest.get_meta(above(pos)):get_inventory():add_item('dst', 'default:iron_lump')
		elseif minetest.get_node(above(under(pos))).name == "mk_items:coal_deposit" then
			minetest.get_meta(above(pos)):get_inventory():add_item('dst', 'default:coal_lump')
		elseif minetest.get_node(above(above(under(pos)))).name == "mk_items:copper_deposit" then
			minetest.get_meta(above(pos)):get_inventory():add_item('dst', 'default:copper_lump')
		end
	end
})