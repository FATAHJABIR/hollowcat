extends Panel

var current_label: int = 0
@onready var labels: Array = [get_child(0), get_child(1), get_child(2)]

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		labels[current_label].visible = false
		current_label += 1
		if current_label <= 2:
			labels[current_label].visible = true
		else:
			queue_free()
