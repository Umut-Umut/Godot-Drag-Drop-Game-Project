extends Node

func clear_item_data(data_dict : Dictionary):
	for key in data_dict:
		data_dict[key] = null


func get_most_panel():
	var panels = GlobalVar.panels
	
	if panels.empty() == true:
		GlobalVar.current_panel = null
		GlobalVar.current_slot = null
		GlobalVar.is_cursor_on_inventory = false
		return
	
	var top_panel = panels[0]
	for panel in panels:
		if panel != top_panel:
			if panel.global_position.y > top_panel.global_position.y:
				top_panel = panel
	GlobalVar.current_panel = top_panel


func add_panel_to_global(object):
	GlobalVar.panels.append(object)
	get_most_panel()


func delete_panel_from_global(object):
	var obji = GlobalVar.panels.find(object)
	GlobalVar.panels.remove(obji)
	get_most_panel()
