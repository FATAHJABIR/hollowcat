extends RigidBody2D
class_name Vase

var player: Player = null
@export var vase_speed: float

func _process(delta):
	if player == null:
		return
		
	if Input.is_action_just_pressed("active_2"):
		player.release_vase()
		player = null
		return

	apply_impulse(player.get_direction() * vase_speed)
