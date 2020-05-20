extends KinematicBody2D

# number of seconds player can jump after leaving ground
const ON_FLOOR_TIME = 0.1

const MAX_SPEED = 64
const GRAVITY = 350
const JUMP_FORCE = 150

# acceleration = speed increase/second when moving
const ACCELERATION = 512
const AIR_ACCELERATION = 200

# friction = speed reduce/second when not moving
const FRICTION = 512
const AIR_FRICTION = 200

onready var sprite = $Sprite

var motion = Vector2.ZERO
var floor_timer = 0

func _ready():
	motion = Vector2.ZERO
	floor_timer = 0
	
func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if is_on_floor():
		floor_timer = 0
	else:
		floor_timer += delta
	
	var on_floor = floor_timer < ON_FLOOR_TIME
	
	if x_input != 0:
		var speed = AIR_ACCELERATION
		if on_floor:
			speed = ACCELERATION
		motion.x += x_input * speed * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	else:
		var friction = AIR_FRICTION
		if on_floor:
			friction = FRICTION
		motion.x = sign(motion.x) * max(0, abs(motion.x) - friction * delta)
	
	motion.y += GRAVITY * delta
	
	if on_floor:
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
	
	motion = move_and_slide(motion, Vector2.UP)
