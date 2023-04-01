class_name Player
extends Body

enum EPlayer { Human, Ghost }

signal health_updated(life)
signal killed()

@export var speed: float
@export var player: EPlayer
@export var bullet_speed: float

var bullet = load("res://Scenes/bullet.tscn")

@export var max_life = 3
@onready var life = max_life : set = _set_life
 

var player1: Player
var player2: Player



func get_direction():
	var direction: Vector2
	
	if player == EPlayer.Human:
		direction.x = Input.get_axis("left_1", "right_1")
		direction.y = Input.get_axis("up_1", "down_1")  
	elif player == EPlayer.Ghost:
		direction.x = Input.get_axis("left_2", "right_2")
		direction.y = Input.get_axis("up_2", "down_2")
	else:
		print("Player %s does not exist" % player)
	
	return direction

func _ready():
	if player == EPlayer.Human:
		player1 = self
	elif player == EPlayer.Ghost:
		player2 = self

func _process(delta):
	if Input.is_action_just_pressed("attack_1"):
		var new_bullet: Bullet = bullet.instantiate()
		new_bullet.linear_velocity = get_direction().normalized() * bullet_speed
		
		
func _physics_process(delta):
	velocity = get_direction() * speed
	move_and_slide()
	
	

func damage(amount):
	_set_life(life-amount)

func kill():
	pass

func _set_life(value):
	var prev_life = life
	life = clamp(value, 0, max_life)
	if life != prev_life:
		emit_signal("life updated", life)
		if life == 0:
			kill()
			emit_signal("killed")
	


func _on_input_event(viewport, event, shape_idx):
	pass
