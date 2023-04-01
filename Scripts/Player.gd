extends CharacterBody2D

enum EPlayer { Human, Ghost }

@export var speed: float
@export var player: EPlayer
@export var life: int

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

func _process(delta):
	velocity = get_direction() * speed
	move_and_slide()
