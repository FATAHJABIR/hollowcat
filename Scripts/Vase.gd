extends RigidBody2D
class_name Vase

var player: Player = null
@export var vase_speed: float
@onready var sprite_normal: Sprite2D = get_node("normal")
@onready var sprite_selected: Sprite2D = get_node("selected")
@onready var sprite_inside: Sprite2D = get_node("inside")

func _process(delta):
	if player == null:
		return
	
	player.transform = transform
		
	if Input.is_action_just_pressed("attack_2"):
		player.release_vase()
		linear_velocity = Vector2.ZERO
		sprite_normal.visible = false
		sprite_selected.visible = true
		sprite_inside.visible = false
		player = null
		return

	linear_velocity = player.get_direction() * vase_speed
