extends Monster

var zombie = load("res://Scenes/monster.tscn")

func spawn():
	var new_zombie: Monster = zombie.instantiate()
	new_zombie.position = position
	new_zombie.connect("ghost_death", _on_monster_death)
	new_zombie.go = true
	new_zombie.reset_life()
	get_parent().add_child(new_zombie)
	print(new_zombie.is_connected("ghost_death", _on_monster_death))

func _on_monster_death():
	print("SPAWN")
	spawn()
