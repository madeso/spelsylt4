extends AnimatedSprite

const RANGE = 20

onready var die_scene = preload("res://bullet-die.tscn")
var timer = 0


func _process(delta):
	timer -= delta
	if timer < 0:
		timer += 0.10
		var g = die_scene.instance()
		var dx = rand_range(-RANGE, RANGE)
		var dy = rand_range(-RANGE, RANGE)
		g.set_position( get_position() + Vector2(dx, dy))
		get_parent().add_child(g)
