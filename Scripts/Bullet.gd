class_name Bullet
extends RigidBody2D

var bullet_owner: Body

func _on_body_entered(body):
	if body == bullet_owner:
		return
	
	if body is Body:
		body.life -= owner.damage
		queue_free()
