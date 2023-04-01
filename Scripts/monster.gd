extends Body
class_name Monster

@onready var player = get_parent().get_node("Player1")
var go = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var target = player.position
	if go  == true:	
		velocity = position.direction_to(target) * speed
		look_at(target)
	move_and_slide()
	if position.distance_to(target) > 10:
		move_and_slide()
	


func _on_area_2d_body_entered(body):
	print("area entered")
	if body is Player:
		print("player enters the area")
		go = true
