extends KinematicBody2D

# number of seconds player can jump after leaving ground
const ON_FLOOR_TIME = 0.1
const ON_WALL_TIME = 0.1

const WALL_JUMP_SPEED = 50
const MAX_SPEED = 64
const GRAVITY = 400

const WALL_SLIDE_SPEED = 12
const WALL_SLIDE_CHANGE = 0.7

# jump while while jumping
const JUMP_FORCE = 140

# jump force after jump has been released
const JUMP_FORCE_AFTER = 80

# in seconds, how long can you hold the jump and be effective
const JUMP_HOLD = 0.18

# in seconds, how long will a jump press be valid...?
const JUMP_BUFFER = 0.1

# acceleration = speed increase/second when moving
const ACCELERATION = 512
const AIR_ACCELERATION = 200

# friction = speed reduce/second when not moving
const FRICTION = 512
const AIR_FRICTION = 200

onready var sprite = $Sprite

enum Anim {Unknown, Idle, Walk, Jump, Slide}

var motion = Vector2.ZERO
var floor_timer = 0
var jump_buffer = 0
var jump_hold = 0
var holding_jump = false
var wall_timer = 0
var old_anim = Anim.Unknown

func _ready():
	motion = Vector2.ZERO
	floor_timer = 0
	jump_buffer = 0
	jump_hold = 0
	holding_jump = false
	wall_timer = 0
	old_anim = Anim.Unknown
	
func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if is_on_floor():
		floor_timer = 0
	else:
		floor_timer += delta
		
	if is_on_wall():
		wall_timer = 0
	else:
		wall_timer += delta
	
	var on_floor = floor_timer < ON_FLOOR_TIME
	var on_wall = wall_timer < ON_WALL_TIME
	
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
	
	var facing_right = not sprite.flip_h
	var sign_dir = -1
	if facing_right:
		sign_dir = 1
	
	if on_wall and not on_floor and motion.y > WALL_SLIDE_SPEED:
		motion.y = max(motion.y - delta*WALL_SLIDE_CHANGE, WALL_SLIDE_SPEED)
	else:
		motion.y += GRAVITY * delta
	
	jump_buffer = min(jump_buffer + delta, JUMP_BUFFER + 1)
	if Input.is_action_just_pressed("ui_up"):
		jump_buffer = 0
	
	if on_floor:
		if jump_buffer < JUMP_BUFFER:
			# standard jump from floor
			jump_buffer = JUMP_BUFFER + 1
			motion.y = -JUMP_FORCE
			floor_timer = ON_FLOOR_TIME + 1
			jump_hold = 0
			holding_jump = true
	else:
		if on_wall and jump_buffer < JUMP_BUFFER:
			# wall jump
			jump_buffer = JUMP_BUFFER + 1
			motion.y = -JUMP_FORCE
			floor_timer = ON_FLOOR_TIME + 1
			jump_hold = 0
			holding_jump = true
			motion.x = -WALL_JUMP_SPEED * sign_dir
		elif Input.is_action_pressed("ui_up"):
			jump_hold = min(jump_hold + delta, JUMP_HOLD + 1)
		else:
			jump_hold = JUMP_HOLD + 1
		
		if holding_jump:
			if jump_hold < JUMP_HOLD:
				motion.y = -JUMP_FORCE
			else:
				motion.y = -JUMP_FORCE_AFTER
				holding_jump = false
	
	motion = move_and_slide(motion, Vector2.UP)
	
	var anim = Anim.Idle
	
	# determine animation state
	if on_floor:
		if abs(motion.x) > 0:
			anim = Anim.Walk
		else:
			anim = Anim.Idle
	elif on_wall:
		anim = Anim.Slide
	else:
		anim = Anim.Jump
	
	# apply new animation if different
	if anim != old_anim:
		if anim == Anim.Idle:
			sprite.animation = "Idle"
		elif anim == Anim.Walk:
			sprite.animation = "Walk"
		elif anim == Anim.Jump:
			sprite.animation = "Jump"
		elif anim == Anim.Slide:
			sprite.animation = "Slide"
		old_anim = anim
	
