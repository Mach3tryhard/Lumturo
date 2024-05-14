extends Control

@onready var audio_stream_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_start_pressed():
	audio_stream_player.play()
	get_tree().change_scene_to_file("res://Scenes/level_menu.tscn")

func _on_options_pressed():
	audio_stream_player.play()
	get_tree().change_scene_to_file("res://Scenes/options.tscn")

func _on_quit_pressed():
	audio_stream_player.play()
	get_tree().quit()
