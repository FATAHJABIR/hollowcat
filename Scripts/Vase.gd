extends RigidBody2D
class_name Vase

var player: Player = null
@export var vase_speed: float
@onready var sprite: Sprite2D = get_node("Sprite2D")

func _process(delta):
	if player == null:
		return
	
	player.transform = transform
		
	if Input.is_action_just_pressed("attack_2"):
		player.release_vase()
		player = null
		return

	linear_velocity = player.get_direction() * vase_speed
