extends Body
class_name Monster

var player: Player
var go = false
@export var monster_type: Player.EPlayer


signal ghost_death()

func _ready():
	reset_life()
	if monster_type == Player.EPlayer.Human:
		player = get_parent().get_node("PlayerHuman")
	elif monster_type == Player.EPlayer.Ghost:
		player = get_parent().get_node("PlayerGhost")

func _physics_process(delta):
	
	var target = player.position
	if go  == true:	
		velocity = position.direction_to(target) * speed
		look_at(target)
		rotate(-PI / 2)
	move_and_slide()
	if position.distance_to(target) > 10:
		move_and_slide()

func _on_area_2d_body_entered(body):
	print("area entered")
	if body is Player:
		print("player enters the area")
		go = true

func _on_killed():
	if monster_type == Player.EPlayer.Human:
		reset_life()
		var new_monster = duplicate()
		new_monster.monster_type = Player.EPlayer.Ghost
		new_monster.set_collision_layer_value(3, false)
		new_monster.set_collision_layer_value(4, true)
		new_monster.set_collision_mask_value(1, false)
		new_monster.set_collision_mask_value(5, false)
		new_monster.set_collision_mask_value(2, true)
		var area2d = new_monster.get_node("Area2D")
		area2d.set_collision_mask_value(1, false)
		area2d.set_collision_mask_value(2, true)
		new_monster.go = true
		new_monster.get_node("Sprite2D").visible = false
		new_monster.get_node("Sprite2D2").visible = true
		
		for signal_name in get_signal_list():
			for connecttion in get_signal_connection_list(signal_name["name"]):
				new_monster.connect(signal_name["name"], connecttion["callable"])
		
		get_parent().add_child(new_monster)
	else:
		emit_signal("ghost_death")
	queue_free()
