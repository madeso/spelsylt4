extends Sprite

var open = true
var blink = 0

const OPEN_TIME = 3
const CLOSED_TIME = 0.2
const CENTER_DIST = 10
onready var sprite = $"."

func _ready():
	blink = rand_range(0, 1)
	open = true


func _process(delta):
	blink += delta
	if open:
		if blink > OPEN_TIME:
			blink -= OPEN_TIME
			open = false
	else:
		if blink > CLOSED_TIME:
			blink -= CLOSED_TIME
			open = true
	if open:
		var player = self.get_node("../Player")
		var dx = player.get_position().x - self.get_position().x
		if abs(dx) < CENTER_DIST:
			sprite.frame = 0
		elif dx > 0:
			sprite.frame = 2
		else:
			sprite.frame = 1
	else:
		sprite.frame = 3
