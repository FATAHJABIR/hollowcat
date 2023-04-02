extends Area2D


var nb: int = 0
@onready var sprite1: Sprite2D = get_node("Sprite2D")
@onready var sprite2: Sprite2D = get_node("Sprite2D2")

func _on_body_entered(body):
	nb += 1
	if nb > 0:
		sprite1.visible = false
		sprite2.visible = true


func _on_body_exited(body):
	nb -= 1
	if nb <= 0:
		sprite1.visible = true
		sprite2.visible = false
