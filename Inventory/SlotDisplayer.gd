extends Control

onready var parent = get_parent().get_parent() # Node2D in Panel.tscn
onready var Icon = $Icon
var data = {}
var is_item = false

func set_item(data_parameter):
	if self.is_item == true:
		if GlobalVar.old_slot == null:
			# Esya envanter disindan dolu slota birakildiysa o zaman dolu slottaki esyayi
			# baska slota tasiyoruz.
			if parent.set_item(data) == false:
				return false
		else:
			# Bu kisimda eger slottan dolu slota esya tasindiysa slot uzerinde hali hazirda
			# bulunan esyayi surukledigimiz esyanin eski slotuna koyuyoruz.
			GlobalVar.old_slot.set_item(data)
	
	GlobalVar.old_slot = null
	
	self.data = data_parameter
	self.load_data()
	self.is_item = true
	
	return true


func swap_item():
	pass


func drop_item():
	is_item = false
	data = {}
	load_data()
	
	GlobalVar.old_slot = self


func load_data():
	confirmation_data(data)
	Icon.texture = data["icon"]
	Icon.modulate = data["icon_color"]


func confirmation_data(data_dict : Dictionary):
	if data_dict.empty() == true:
		data_dict["icon"] = GlobalVar.empty_image
		data_dict["icon_color"] = Color(1, 1, 1, 1)


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if GlobalVar.current_panel == parent:
		if event.is_action_pressed("ui_mouse_left"):
			if is_item == true:
				var displayer = GlobalVar.itemDisplayer_scene.instance()
				displayer.data = data
				displayer.pick()
				drop_item()
				GlobalVar.node_items_in_world.add_child(displayer)
		
		
		# Üst üste duran iki envanter panelinde sorun çıkmaması için önceki slotun exit
		# fonksiyonunu çağırıyor.
		if GlobalVar.current_slot != null and GlobalVar.current_slot.parent != parent:
			GlobalVar.current_slot._on_Area2D_mouse_exited()
		
		GlobalVar.current_slot = self
		
		if is_item == false:
			Icon.modulate = Color(0, 1, 0)


func _on_Area2D_mouse_exited():
	if is_item == false:
		Icon.modulate = Color(1, 1, 1)
