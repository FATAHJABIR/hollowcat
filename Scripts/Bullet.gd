class_name Bullet
extends RigidBody2D

var bullet_owner: Body

func _ready():
	if bullet_owner is Player:
		if bullet_owner.player == Player.EPlayer.Ghost:
			var area2d: Area2D = get_node("Area2D")
			area2d.set_collision_mask_value(3, false)
			area2d.set_collision_mask_value(5, false)
			area2d.set_collision_mask_value(4, true)

func _on_area_2d_body_entered(body):
	if body is Body:
		body.damage(1)
	queue_free()

