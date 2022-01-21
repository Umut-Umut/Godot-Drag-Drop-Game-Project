extends Node

# For Drag & Drop
var is_cursor_empty = true
var held_item = null
var mouse_point_vector = Vector2(0, 0)



# For Player
var player = null


# For Inventory
var current_slot = null # set null from GlobalFunc.gd -> most_panel
var old_slot = null # for swap item in inventory SlotDisplayer.gd | drop_item()
var current_panel = null
var node_items_in_world = null # use in SlotDisplayer.gd
var itemDisplayer_scene = null # use in SlotDipslayer.gd
var empty_image = load("res://Inventory/images/empty.png")
var null_image = load("res://icon.png")
var panels = []
var most_panel = null
var is_cursor_on_inventory = false # set null from GlobalFunc.gd -> most_panel
