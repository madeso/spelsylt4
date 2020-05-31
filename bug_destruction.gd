extends AudioStreamPlayer2D

func _process(_delta):
	if !playing:
		queue_free()
