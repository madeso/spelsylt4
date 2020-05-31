extends Node2D

onready var sfx = $SfxJumpOut

func jump_out():
	sfx.play()

func cinema_done():
	get_tree().change_scene("res://world.tscn")
