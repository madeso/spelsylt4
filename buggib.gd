extends KinematicBody2D

onready var sprite = $Sprite

const FRICTION = 3.5
const GRAVITY = 100
const BOUNCY = 0.4

var move = Vector2.ZERO

func _ready():
	sprite.flip_h = randf() > 0.5
	sprite.flip_v = randf() > 0.5
	if randf() > 0.5:
		sprite.frame = 3
	else:
		sprite.frame = 2
	
	move.x = rand_range(-10, 10) * 3
	move.y = rand_range(-5, -10) * 8

func _physics_process(delta):
	if is_on_floor():
		move.y = -move.y * BOUNCY
		if abs(move.y) < 10:
			move.y = 0
	else:
		move.y += delta * GRAVITY
	if abs(move.x) > 0:
		move.x = sign(move.x) * max(0, abs(move.x) - delta * FRICTION)
	var m = move_and_slide(move, Vector2.UP)
	move.x = m.x
