extends Sprite



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.pickup_energy()
		queue_free()
