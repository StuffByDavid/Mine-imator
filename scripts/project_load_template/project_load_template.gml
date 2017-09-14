/// project_load_template(map)
/// @arg map

var map = argument0;

if (!ds_map_valid(map))
	return 0

with (new(obj_template))
{
	loaded = true
	
	load_id = json_read_string(map[?"id"], save_id)
	save_id_map[?load_id] = load_id
	
	type = json_read_string(map[?"type"], type)
	name = json_read_string(map[?"name"], name)

	if (type = "char" || type = "spblock" || type = "bodypart")
	{
		skin = json_read_save_id(map[?"skin"], skin)
		var modelmap = map[?"model"];
		if (ds_map_valid(modelmap))
		{
			model_name = json_read_string(modelmap[?"name"], model_name)
			model_state = json_read_string(modelmap[?"state"], model_state)
			if (type = "bodypart")
				model_part_name = json_read_string(modelmap[?"part_name"], model_part_name)
		}
	}
	else if (type = "item")
	{
		var itemmap = map[?"item"];
		if (ds_map_valid(itemmap))
		{
			item_tex = json_read_save_id(itemmap[?"tex"], item_tex)
			if (!is_undefined(itemmap[?"name"]))
				item_slot = ds_list_find_index(mc_assets.item_texture_list, json_read_string(itemmap[?"name"]))
			else
				item_slot = json_read_real(itemmap[?"slot"], item_slot)
			item_3d = json_read_real(itemmap[?"3d"], item_3d)
			item_face_camera = json_read_real(itemmap[?"face_camera"], item_face_camera)
			item_bounce = json_read_real(itemmap[?"bounce"], item_bounce)
		}
	}
	else if (type = "block")
	{
		var blockmap = map[?"block"];
		if (ds_map_valid(blockmap))
		{
			block_name = json_read_string(blockmap[?"name"], block_name)
			block_state = json_read_string(blockmap[?"state"], block_state)
			block_tex = json_read_save_id(blockmap[?"tex"], block_tex)
			block_repeat_enable = json_read_real(blockmap[?"repeat_enable"], block_repeat_enable)
			block_repeat = json_read_array(blockmap[?"repeat"], block_repeat)
		}
	}
	if (type = "scenery")
	{
		scenery = json_read_save_id(map[?"scenery"], scenery)
		var blockmap = map[?"block"];
		if (ds_map_valid(blockmap))
		{
			block_tex = json_read_save_id(blockmap[?"tex"], block_tex)
			block_repeat_enable = json_read_real(blockmap[?"repeat_enable"], block_repeat_enable)
			block_repeat = json_read_array(blockmap[?"repeat"], block_repeat)
		}
	}
	
	if (type_is_shape(type))
	{
		var shapemap = map[?"shape"];
		if (ds_map_valid(shapemap))
		{
			shape_tex = json_read_save_id(shapemap[?"tex"], shape_tex)
			shape_tex_mapped = json_read_real(shapemap[?"tex_mapped"], shape_tex_mapped)
			shape_tex_hoffset = json_read_real(shapemap[?"tex_hoffset"], shape_tex_hoffset)
			shape_tex_voffset = json_read_real(shapemap[?"tex_voffset"], shape_tex_voffset)
			shape_tex_hrepeat = json_read_real(shapemap[?"tex_hrepeat"], shape_tex_hrepeat)
			shape_tex_vrepeat = json_read_real(shapemap[?"tex_vrepeat"], shape_tex_vrepeat)
			shape_tex_hmirror = json_read_real(shapemap[?"tex_hmirror"], shape_tex_hmirror)
			shape_tex_vmirror = json_read_real(shapemap[?"tex_vmirror"], shape_tex_vmirror)
			shape_closed = json_read_real(shapemap[?"closed"], shape_closed)
			shape_invert = json_read_real(shapemap[?"invert"], shape_invert)
			shape_detail = json_read_real(shapemap[?"detail"], shape_detail)
			shape_face_camera = json_read_real(shapemap[?"face_camera"], shape_face_camera)
		}
	}
	else if (type = "text")
	{
		var textmap = map[?"text"];
		if (ds_map_valid(textmap))
		{
			text_font = json_read_save_id(textmap[?"font"], text_font)
			text_3d = json_read_real(textmap[?"3d"], text_3d)
			text_face_camera = json_read_real(textmap[?"face_camera"], text_face_camera)
		}
	}
	else if (type = "particles")
		project_load_particles(map[?"particles"])
	
	if (temp_creator = app)
		sortlist_add(app.lib_list, id)
}