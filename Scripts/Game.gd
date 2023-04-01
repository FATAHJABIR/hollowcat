extends Node

func _ready():
	get_node("HBoxContainer/SubViewportContainer2/SubViewport").world_2d = get_node("HBoxContainer/SubViewportContainer/SubViewport").world_2d
