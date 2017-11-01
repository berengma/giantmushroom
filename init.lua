 
local path = minetest.get_modpath(minetest.get_current_modname())
local decay = true


minetest.register_node("giantmushroom:mushroom_sapling", {
	description = "Giantmushroom Sapling",
	tiles = {"giantmushroom_sapling.png"},
	drawtype = "plantlike",
	is_ground_content = false,
	groups = {cracky=1, oddly_breakable_by_hand=1}
})



minetest.override_item("caverealms:mushroom_gills", {
  
      after_dig_node = function(pos, oldnode, oldmetadata, player)
	    local rnd = math.random(1, 100)
	    
	    if rnd < 11 then
		
	        minetest.spawn_item(pos, "giantmushroom:mushroom_sapling")
		
	    end
end})

if decay then
	  minetest.register_abm({
		  label = "Mushroom decay",
		  nodenames = {"caverealms:mushroom_stem", "caverealms:mushroom_cap", "caverealms:mushroom_gills"},
		  interval = 20,
		  chance = 33,
		  action = function(pos, node)
		  
			  local cpos = ({x=pos.x, y = pos.y + 1, z = pos.z})
			  local check = minetest.get_node_light(cpos, nil)
			  if check then
				if check > 8 then
					minetest.dig_node(pos)
					return
				end
			  end
		  end
	  })
end


minetest.register_abm({
	label = "Mushroom growth",
	nodenames = {"giantmushroom:mushroom_sapling"},
	interval = 5,
	chance = 80,
	action = function(pos, node)
	
		grow_mushroom(pos)
		
	end
})


function grow_mushroom(pos)
	minetest.remove_node(pos)
	minetest.place_schematic({ x = pos.x - 5, y = pos.y, z = pos.z - 5 }, path.."/schems/giantmushroom.mts", "random", nil, false)
end


