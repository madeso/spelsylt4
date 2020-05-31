extends Area2D

onready var text = $center/panel/text

export var help = ""

func _ready():
	visible = false
	text.text = help


func _on_Area2D2_body_entered(_body):
	visible = true


func _on_Area2D2_body_exited(_body):
	visible = false
