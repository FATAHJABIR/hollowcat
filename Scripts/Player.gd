extends CharacterBody2D

enum EPlayer { Player1, Player2 }

@export var speed: float
@export var player: EPlayer

func get_direction():
	var direction: Vector2
	
	if player == EPlayer.Player1:
		direction.x = Input.get_axis("left_1", "right_1")
		direction.y = Input.get_axis("up_1", "down_1")
	elif player == EPlayer.Player2:
		direction.x = Input.get_axis("left_2", "right_2")
		direction.y = Input.get_axis("up_2", "down_2")
	else:
		print("Player %s does not exist" % player)
	
	return direction

func _process(delta):
	velocity = get_direction() * speed
	move_and_slide()
