extends KinematicBody2D

const SPEED = 180
var facing_right = false
onready var sprite = $Sprite

func _physics_process(delta):
	var motion = Vector2.ZERO
	sprite.flip_h = !facing_right
	if facing_right:
		motion.x = SPEED
	else:
		motion.x = -SPEED
	
	var collision = move_and_collide(motion * delta)
	if collision != null:
		self.queue_free()
