extends RigidBody2D
class_name Door

var open: bool = false
@export var speed: float = 100
@export var open_size: float = 100
@onready var start_y: float = position.y
@onready var close_position: float = position.x
@onready var open_position: float = position.x + open_size

func _process(delta):
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
