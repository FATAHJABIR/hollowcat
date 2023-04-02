class_name Player
extends Body

enum EPlayer { Human, Ghost }


@export var player: EPlayer
@export var bullet_speed: float

@onready var area2d: Area2D = get_node("Area2D")
@onready var invulnerability_timer = $immunityTimer
@onready var animation_tree = $AnimationTree
@export var starting_direction : Vector2 = Vector2(0, 0.5)
@onready var state_machine = animation_tree.get('parameters/playback')

var bullet = load("res://Scenes/bullet.tscn")

var last_normalized_direction: Vector2 = Vector2.RIGHT
var direction: Vector2


var player1: Player
var player2: Player

@export var life_system: LifeSystem

@onready var sound: AudioStreamPlayer2D = get_tree().root.get_child(0).get_node("bullet_shot")


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
	connect("health_updated", life_system.on_player_life_change)
	life_system.on_player_life_change(max_life)
	
	update_animation_parameters(starting_direction)

func _process(delta):
	direction = get_direction()
	if direction.length_squared() > 0.0001:
		last_normalized_direction = direction.normalized()
	
	if Input.is_action_just_pressed("attack_1") and player == EPlayer.Human \
	or Input.is_action_just_pressed("attack_2") and player == EPlayer.Ghost:
		sound.play()
		var new_bullet: Bullet = bullet.instantiate()
		new_bullet.apply_central_impulse(last_normalized_direction * bullet_speed)
		new_bullet.position = position
		new_bullet.bullet_owner = self
		if player == EPlayer.Human:
			new_bullet.get_node("Sprite2D").frame = 1
		get_parent().add_child(new_bullet)
	

func damage(amount):
	if invulnerability_timer.is_stopped():
		effects_animations.play("Red")
		effects_animations.queue("flash")
		_set_life(life-amount)
		invulnerability_timer.start()

func _physics_process(delta):
	velocity = direction * speed
	update_animation_parameters(velocity)
	move_and_slide()
	pick_new_state()

func _on_monster_detector_body_entered(body):
	if body is Monster:
		damage(1)

func _on_immunity_timer_timeout():
	var is_reattacked: bool = false
	for body in area2d.get_overlapping_bodies():
		if body is Monster:
			is_reattacked = true
	
	if is_reattacked:
		damage(1)
	else:
		effects_animations.play("rest")


func _on_killed():
	effects_animations.play("death")
	get_tree().reload_current_scene()

func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)
	
func pick_new_state():
	if (velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else: 
		state_machine.travel("Idle")
