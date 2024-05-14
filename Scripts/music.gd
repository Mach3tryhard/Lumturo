extends AudioStreamPlayer2D

@onready var music = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	music.play()

func _on_finished():
	music.play()
