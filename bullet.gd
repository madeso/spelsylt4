extends KinematicBody2D

const SPEED = 180
var facing_right = false
onready var sprite = $Sprite

onready var die_scene = preload("res://bullet-die.tscn")

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
		if collision.collider.has_method("damage"):
			collision.collider.damage()
		else:
			var g = die_scene.instance()
			g.set_position( get_position() )
			get_parent().add_child(g)
