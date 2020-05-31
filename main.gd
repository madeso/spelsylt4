extends Node

#func _input(event):
#	if event is InputEventKey and event.pressed:
#		next_scene()

func _process(_delta):
	if Input.is_action_just_released("ui_accept"):
		next_scene()

func next_scene():
	get_tree().change_scene("res://cinema-start.tscn")
