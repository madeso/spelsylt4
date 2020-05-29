extends AudioStreamPlayer2D

func _process(delta):
	if !playing:
		queue_free()
