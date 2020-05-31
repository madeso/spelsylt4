extends AnimatedSprite

const SPEED = 0.2
const DIST = 13

var timer = 0
var p = Vector2.ZERO

func _ready():
	p = get_position()


func _process(delta):
	timer += delta * PI*2 * SPEED
	if timer > PI*2:
		timer -= PI * 2
	var dy = sin(timer) * DIST
	set_position( p + Vector2(0, dy) )
