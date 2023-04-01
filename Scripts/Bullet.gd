class_name Bullet
extends RigidBody2D

var bullet_owner: Body

func _on_body_entered(body):
	print("kiiuh")
	body.life -= bullet_owner.damage
	queue_free()
