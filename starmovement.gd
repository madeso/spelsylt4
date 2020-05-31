extends Node2D


const WIDTH = 320
var timer = 0

func _process(delta):
	timer += delta * 100
	if timer > WIDTH:
		timer -= WIDTH
	
	set_position(Vector2(timer, 0))
