extends Control
@onready var audio_stream_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_6_pressed():
	audio_stream_player.play()
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
