extends Sprite


var life = 0.05

func _process(delta):
	life -= delta
	if life < 0:
		queue_free()
