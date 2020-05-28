extends AnimatedSprite

func _ready():
	self.frame = randi() % 4
	self.playing = true
