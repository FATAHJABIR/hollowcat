extends Control
class_name LifeSystem

var heart_size: int = 48
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_player_life_change(life):
	var d = $Hearts.size.x
	$Hearts.size.x = life * heart_size
