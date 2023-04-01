class_name Bullet
extends RigidBody2D

func _on_body_entered(body):
	print("kiiuh")
	body.life -= owner.damage
	queue_free()
