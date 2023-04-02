extends RigidBody2D
class_name Door

var open: bool = false
var last_open: bool = false
@export var speed: float = 220
@export var open_size: float = 400
@onready var start_y: float = position.y
@onready var close_position: float = position.x
@onready var open_position: float = position.x + open_size
@onready var sound: AudioStreamPlayer2D = get_tree().root.get_child(0).get_node("door_open")

func _process(delta):
	if last_open != open:
		sound.play()
	last_open = open
	
	position.y = start_y
	linear_velocity = Vector2.ZERO
	
	if open:
		if position.x < open_position:
			freeze = false
			linear_velocity = Vector2(speed, 0)
		else:
			position.x = open_position
			freeze = true
	else:
		if position.x > close_position:
			freeze = false
			linear_velocity = Vector2(-speed, 0)
		else:
			position.x = close_position
			freeze = true
