extends KinematicBody2D

signal clicked

onready var Icon = get_node("Icon")

var data = {
	"icon" : null,
	"icon_color" : null,
}

func _ready():
	var _garbage = connect("clicked", get_tree().get_current_scene(), "_on_ItemDisplayer_clicked")
	load_data()
	
	var isize = Icon.rect_size
	self.get_node("CollisionShape2D").shape.extents = isize / 2


func _input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("ui_mouse_left"):
		if GlobalVar.current_panel == null:
			emit_signal("clicked", self) # in World.gd
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#
#			# Envanter üzerinden arkadaki nesnelere tıklanmasına engel oluyor.
#			if GlobalVar.current_panel == null:
#				emit_signal("clicked", self) # in World.gd


func load_data():
	self.confirmation_item_data(data)
	
	Icon.texture = data["icon"]
	Icon.modulate = data["icon_color"]


func confirmation_item_data(data_dict : Dictionary):
	if data_dict["icon"] == null:
		data_dict["icon"] = GlobalVar.null_image
		var _garbage = rand_seed(0)
		data_dict["icon_color"] = Color(randf(), randf(), randf())


func pick():
	self.z_index = 2
	GlobalVar.held_item = self
	if self.is_inside_tree() == true:
		GlobalVar.mouse_point_vector = get_global_mouse_position() - GlobalVar.held_item.global_position


func drop():
	var is_delete = false
#
#	if GlobalVar.is_cursor_on_inventory == true:
#		if GlobalVar.current_slot != null:
#			res = GlobalVar.current_slot.set_item(data)
	
	is_delete = is_drop_to_inventory()
	
	self.z_index = 0
	GlobalVar.held_item = null
	# Slot uzerinden esya alinca onceki mouse_point_vector degerini kullanmamasi icin
	# birakilan her esyada bu degeri sifirliyoruz.
	GlobalVar.mouse_point_vector = Vector2(0, 0)
	# Envanter içindeki eşya envanterden çıkartılıp yere bırakıldığında old slot
	# değeri null'a eşitlenmiyor. Bu da daha sonra bu eşyayı başka envanterdeki
	# başka eşyanın üzerine koyunca eski slot ile swap yapmasına sebep oluyor.
	# set_item'in dışında burada da null eşitlemesi yaptım.
	GlobalVar.old_slot = null
	
	if is_delete == true:
		self.queue_free()


func is_drop_to_inventory():
	if GlobalVar.is_cursor_on_inventory == true:
		if GlobalVar.current_slot != null:
			return GlobalVar.current_slot.set_item(data)
