class_name Body
extends CharacterBody2D

@export var max_life = 3
@onready var life = max_life : set = _set_life

@export var speed: float

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

signal health_updated(life)
signal killed()