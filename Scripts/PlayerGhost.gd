class_name PlayerGhost
extends Player

@export var max_distance_between_players: float

func _process(delta):
	var distance_between_players: float = (player1.position - player2.position).length()
	
	if distance_between_players > max_distance_between_players:
		pass
