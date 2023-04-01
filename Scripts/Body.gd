class_name Body
extends CharacterBody2D

@export var max_life = 3
@onready var life = max_life : set = _set_life
@onready var effects_animations = $AnimationPlayer

@export var speed: float
@export var power: float

func damage(amount):
	_set_life(life-amount)

func _set_life(value):
	var prev_life = life
	life = clamp(value, 0, max_life)
	if life != prev_life:
		emit_signal("life updated", life)
		if life == 0:
			emit_signal("killed")

signal health_updated(life)
signal killed()
