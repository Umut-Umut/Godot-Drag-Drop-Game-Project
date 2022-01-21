extends Node2D

var slots = [
	[null, null, null],
	[null, null, null],
	[null, null, null],
]

func _ready():
	self.z_index = 1
	
	var slot_displayer = load("res://Inventory/SlotDisplayer.tscn")
	for i in range(3):
		for ii in range(3):
			slots[i][ii] = slot_displayer.instance()
			$GridContainer.add_child(slots[i][ii])


func set_item(data):
	for slot_row in slots:
		for slot in slot_row:
			if slot.is_item == false:
				slot.set_item(data)
				return true
	return false


func _on_Area2D_mouse_entered():
	GlobalVar.is_cursor_on_inventory = true
	GlobalFunc.add_panel_to_global(self)


func _on_Area2D_mouse_exited():
	GlobalFunc.delete_panel_from_global(self)
