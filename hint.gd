extends Area2D

onready var text = $center/panel/text

export var help = ""

func _ready():
	text.text = help
	visible = false

func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		visible = true


func _on_Area2D2_body_exited(body):
	if body.name == "Player":
		visible = false
