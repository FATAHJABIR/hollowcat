class_name PlayerGhost
extends Player

@export var max_distance_between_players: float
@export var callback_factor: float = 0.01

var is_grabbing_vase: bool = false

func _process(delta):
	if is_grabbing_vase:
		direction = get_direction()
		return
	
	var player_vector = player2.position - player1.position
	var distance_between_players: float = player_vector.length()
	
	check_grab_vase()
		
	if distance_between_players > max_distance_between_players:
		position -= player_vector * callback_factor
	
	super._process(delta)

func _physics_process(delta):
	if is_grabbing_vase:
		return
	
	super._physics_process(delta)

func check_grab_vase():
	if not Input.is_action_just_pressed("active_2"):
		return
	
	for body in area2d.get_overlapping_bodies():
		if body is Vase:
			grab_vase(body)
			return

func grab_vase(vase: RigidBody2D):
	is_grabbing_vase = true
	transform = vase.transform
	visible = false
	vase.player = self

func release_vase():
	is_grabbing_vase = false
	visible = true


func _on_area_2d_body_entered(body):
	if body is Vase:
		body.sprite.frame = 1


func _on_area_2d_body_exited(body):
	if body is Vase:
		body.sprite.frame = 0
