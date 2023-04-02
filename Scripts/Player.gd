class_name Player
extends Body

enum EPlayer { Human, Ghost }


@export var player: EPlayer
@export var bullet_speed: float

var bullet = load("res://Scenes/bullet.tscn")

var rifu = max_life

var last_normalized_direction: Vector2 = Vector2.RIGHT
var direction: Vector2


var player1: Player
var player2: Player



func get_direction():
	var new_direction: Vector2
	

	if player == EPlayer.Human:
		new_direction.x = Input.get_axis("left_1", "right_1")
		new_direction.y = Input.get_axis("up_1", "down_1")  
	elif player == EPlayer.Ghost:
		new_direction.x = Input.get_axis("left_2", "right_2")
		new_direction.y = Input.get_axis("up_2", "down_2")
	else:
		print("Player %s does not exist" % player)
	
	return new_direction

func _ready():
	player1 = get_node("../PlayerHuman")
	player2 = get_node("../PlayerGhost") 
	connect("health_updated", get_parent().get_node("Life/UI/Life").on_player_life_change)
	emit_signal("health_updated", max_life)

func _process(delta):
	direction = get_direction()
	if direction.length_squared() > 0.0001:
		last_normalized_direction = direction.normalized()
	
	if Input.is_action_just_pressed("attack_1") and player == EPlayer.Human \
	or Input.is_action_just_pressed("attack_2") and player == EPlayer.Ghost:  
		var new_bullet: Bullet = bullet.instantiate()
		new_bullet.apply_central_impulse(last_normalized_direction * bullet_speed)
		new_bullet.position = position
		new_bullet.bullet_owner = self
		get_tree().root.add_child(new_bullet)
		
func damage(amount):
	if invulnerability_timer.is_stopped():
		effects_animations.play("Red")
		effects_animations.queue("flash")
		_set_life(life-amount)
		invulnerability_timer.start()

func _physics_process(delta):
	velocity = direction * speed
	move_and_slide()

func _on_monster_detector_body_entered(body):
	damage(1)

func _on_immunity_timer_timeout():
	if get_node("monsterDetector").has_overlapping_bodies():
		damage(1)
	else:
		effects_animations.play("rest")


func _on_killed():
	effects_animations.play("death")
	get_tree().reload_current_scene()
