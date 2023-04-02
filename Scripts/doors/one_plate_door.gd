extends Door

var nb_body_on_plate_1: int = 0
var nb_body_on_plate_2: int = 0

func should_open():
	if nb_body_on_plate_1 + nb_body_on_plate_2 == 1:
		open = true

func _on_door_plate_body_entered(body):
	nb_body_on_plate_1 += 1
	should_open()

func _on_door_plate_2_body_entered(body):
	nb_body_on_plate_2 += 1
	should_open()
	
func should_close():
	if nb_body_on_plate_1 + nb_body_on_plate_2 == 0:
		open = false

func _on_door_plate_body_exited(body):
	nb_body_on_plate_1 -= 1
	should_close()

func _on_door_plate_2_body_exited(body):
	nb_body_on_plate_2 -= 1
	should_close()
