extends StaticBody2D

onready var Icon = get_parent().get_node("Icon")
var item_data = null


func _input_event(_viewport, _event, _shape_idx):
	pass


func set_item():
	Icon.texture = item_data["image"]
	Icon.modulate = item_data["image_color"]
