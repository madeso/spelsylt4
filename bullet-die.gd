extends Node2D

onready var sfx = $Sfx
onready var sprite = $Sprite

func _ready():
	sfx.play()
	sprite.play()


func _process(_delta):
	if sprite.frame == 4:
		sprite.visible = false
	if sprite.visible == false and !sfx.playing:
		queue_free()
