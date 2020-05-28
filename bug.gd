extends KinematicBody2D

const SPEED = 8
const CLIFF_DISTANCE = 10

var move = Vector2.ZERO
var facing_right = true

func damage():
	self.queue_free()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var moving = is_on_floor()
	var dx = 0
	if moving:
		dx = 1
		if !facing_right:
			dx = -1
	move.x = SPEED * dx
	move.y = 10
	move = move_and_slide(move, Vector2.UP)
	if moving:
		if move.x == 0:
			facing_right = !facing_right
		else:
			# check to see if we are going near a cliff
			if !test_move(Transform2D(0, position + Vector2.RIGHT * dx * CLIFF_DISTANCE), Vector2.DOWN):
				facing_right = !facing_right
