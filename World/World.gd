extends Node2D

func _ready():
	GlobalVar.node_items_in_world = get_node("Items")
	GlobalVar.itemDisplayer_scene = load("res://DragAndDrop/ItemDisplayer/ItemDisplayer.tscn")
	
	OS.window_fullscreen = true


func _process(_delta):
	# DRAG AND DROP
	if GlobalVar.held_item != null:
		GlobalVar.held_item.global_position = get_global_mouse_position() - GlobalVar.mouse_point_vector


func _input(event):
	if event is InputEventMouseButton:
		
		if GlobalVar.held_item != null:
			if event.is_action_released("ui_mouse_left"):
				GlobalVar.held_item.drop()
		
#		# IF DROP OBJECT
#		if GlobalVar.held_item != null:
#			if event.button_index == BUTTON_LEFT and !event.pressed:
#				GlobalVar.held_item.drop()
				
	# QUIT GAME
	if event is InputEventKey and event.scancode == KEY_Q:
		if event.pressed and not event.is_echo():
			get_tree().quit()


func _on_ItemDisplayer_clicked(item):
	if GlobalVar.held_item == null:
		item.pick()
	
	elif item.global_position.y > GlobalVar.held_item.global_position.y:
		GlobalVar.held_item.drop()
		item.pick()
