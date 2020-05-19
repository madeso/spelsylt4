extends KinematicBody2D

const ACCELERATION = 512
const MAX_SPEED = 64
const FRICTION = 0.25
const GRAVITY = 350
const JUMP_FORCE = 150

var motion = Vector2.ZERO

func _ready():
	pass
	
func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if x_input != 0:
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
	
	motion.y += GRAVITY * delta
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
	
	motion = move_and_slide(motion, Vector2.UP)

func _process(delta):
	pass
