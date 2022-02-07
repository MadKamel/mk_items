-- Register the conveyor node.
minetest.register_node("mk_items:conveyor", {
	description = "Conveyor Belt",
	tiles = {
		{
			name="mk_conveyor_anim.png",
			animation={
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8
			}
		},
		{
			name="mk_conveyor_counteranim.png",
			animation={
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8
			}
		},
		"mk_conveyor_side.png",
		"mk_conveyor_side.png",
		"mk_conveyor_end.png",
		"mk_conveyor_end.png"
	},
	groups = {oddly_breakable_by_hand = 3},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	legacy_facedir_simple = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,-0.25,0.5}
		}
	}
})

-- Register the moving entity, and make a function to create it.
minetest.register_entity("mk_items:moving_item", {
	initial_properties = {
		hp_max = 1,
		physical = false,
		collisionbox = {0.125, 0.125, 0.125, 0.125, 0.125, 0.125},
		visual = "wielditem",
		visual_size = {x = 0.25, y = 0.25},
		textures = {""},
		spritediv = {x = 1, y = 1},
		initial_sprite_basepos = {x = 0, y = 0},
		is_visible = false,
	},

	physical_state = true,
	itemstring = '',
	set_item = function(self, itemstring)
		self.itemstring = itemstring
		local stack = ItemStack(itemstring)
		local count = stack:get_count()
		local max_count = stack:get_stack_max()
		if count > max_count then
			count = max_count
			self.itemstring = stack:get_name().." "..max_count
		end
		local s = 0.15 + 0.15 * (count / max_count)
		local c = 0.8 * s
		local itemtable = stack:to_table()
		local itemname = nil
		if itemtable then
			itemname = stack:to_table().name
		end
		--[[local item_texture = nil
		local item_type = ""
		if minetest.registered_items[itemname] then
			item_texture = minetest.registered_items[itemname].inventory_image
			item_type = minetest.registered_items[itemname].type
		end--]]
		local prop = {
			is_visible = true,
			visual = "wielditem",
			textures = {itemname},
			visual_size = {x = s, y = s},
			collisionbox = {-c, -c, -c, c, c, c},
			--automatic_rotate = math.pi * 0.2,
		}
		self.object:set_properties(prop)
	end,

	get_staticdata = function(self)
		return minetest.serialize({
			itemstring = self.itemstring
		})
	end,

	on_activate = function(self, staticdata)
		if string.sub(staticdata, 1, string.len("return")) == "return" then
			local data = minetest.deserialize(staticdata)
			if data and type(data) == "table" then
				self.itemstring = data.itemstring
			end
		else
			self.itemstring = staticdata
		end
		self.object:set_armor_groups({immortal = 1})
		self:set_item(self.itemstring)
	end,

	on_step = function(self)
		local pos = self.object:getpos()
		local speed = 1.6 -- About 60 Units Per Minute.
		local apos = vector.round(pos) -- Gets rid of the little irregularities
		apos.y = apos.y + 1 -- Shift the y up by one.
		local napos = minetest.get_node(pos)
		-- Dir is a copy of Facedir, because we don't want to override Facedir for obvious reasons.
		local dir = vector.new(minetest.facedir_to_dir(napos.param2))
		if napos.name == "mk_items:conveyor" then
			dir.y = math.floor(pos.y + 0.5) + 0.15 - pos.y -- Target's height
			if dir.x == 0 then
				dir.x = (apos.x - pos.x) * 2
			elseif dir.z == 0 then
				dir.z = (apos.z - pos.z) * 2
			end
			self.object:setvelocity(vector.divide(dir, speed))
		else
			local stack = ItemStack(self.itemstring)
			local veldir = self.object:getvelocity();
			minetest.add_item({x = pos.x + veldir.x / 3, y = pos.y, z = pos.z + veldir.z / 3}, stack)
			self.object:remove()
		end
	end
})

function do_moving_item(pos, item)
	if item == ":" or item == "" then
		return
	end
	local stack = ItemStack(item)
	local obj = minetest.add_entity(pos, "mk_items:moving_item")
	obj:get_luaentity():set_item(stack:to_string())
	return obj
end


-- Now that we've registered all the needed stuff, here's an ABM to grab stuff from their dropped state to moving on the conveyor.
minetest.register_abm({
	nodenames = {"mk_items:conveyor"},
	interval = 1,
	chance = 1,
	action = function(pos, node, aoc, aoc_wide)
		if aoc_wide == 0 then
			return
		end
		local all_objects = minetest.get_objects_inside_radius(pos, 0.75) -- The radius to search for items is 0.75
		for aoc, obj in ipairs(all_objects) do
			if obj:get_luaentity() and obj:get_luaentity().name == "__builtin:item" then
				do_moving_item({x = pos.x, y = pos.y + 0.15, z = pos.z}, obj:get_luaentity().itemstring)
				obj:get_luaentity().itemstring = ""
				obj:remove()
			end
		end
	end,
})