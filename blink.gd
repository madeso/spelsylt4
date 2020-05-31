extends Label

const TIME = 0.5
var timer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	timer -= delta
	if timer < 0:
		timer += TIME
		visible = !visible
