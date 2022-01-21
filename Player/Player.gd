extends KinematicBody2D

onready var camera = get_node("Camera2D") 

var velocity = Vector2(0, 0)
var speed = 200

var strengthX = 0
var strengthY = 0

func _ready():
	pass


func _process(_delta):
	# MOVE
	strengthX = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	strengthY = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity = Vector2(strengthX, strengthY)
	velocity = move_and_slide(velocity * speed)
