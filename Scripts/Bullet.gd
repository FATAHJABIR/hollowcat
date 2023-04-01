class_name Bullet
extends RigidBody2D

var bullet_owner: Body

func _on_area_2d_body_entered(body):
	body.damage(1)
	queue_free()
