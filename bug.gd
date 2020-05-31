extends KinematicBody2D

onready var gib_scene = preload("res://buggib.tscn")
onready var destruction_scene = preload("res://bug_destruction.tscn")

const SPEED = 8
const CLIFF_DISTANCE = 10

var move = Vector2.ZERO
var facing_right = true
var health = 3
onready var sprite = $AnimatedSprite

onready var sfx_hurt = $SfxHurt

func gib():
	var g = gib_scene.instance()
	g.set_position( get_position() )
	get_parent().add_child(g)

func damage():
	if health > 1:
		health -= 1
		sfx_hurt.play()
	else:
		var g = destruction_scene.instance()
		g.set_position( get_position() )
		get_parent().add_child(g)
		self.queue_free()
		for _n in range(5):
			gib()

func _ready():
	sprite.playing = true
	pass # Replace with function body.

func _physics_process(_delta):
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
