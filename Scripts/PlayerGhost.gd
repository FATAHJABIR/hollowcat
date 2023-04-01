class_name PlayerGhost
extends Player

@export var max_distance_between_players: float
@export var callback_factor: float = 0.01

func _process(delta):
	var player_vector = player2.position - player1.position
	var distance_between_players: float = player_vector.length()
	
	if distance_between_players > max_distance_between_players:
		position -= player_vector * callback_factor
	
	super._process(delta)
