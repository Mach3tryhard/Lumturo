extends Control

@onready var audio_stream_player = $AudioStreamPlayer
@onready var timer = $Timer


var level_selected=0

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_level_1_pressed():
	audio_stream_player.play()
	level_selected=1
	timer.start()

func _on_level_2_pressed():
	audio_stream_player.play()
	level_selected=2
	timer.start()

func _on_level_3_pressed():
	audio_stream_player.play()
	level_selected=3
	timer.start()

func _on_level_4_pressed():
	audio_stream_player.play()
	level_selected=4
	timer.start()

func _on_level_5_pressed():
	audio_stream_player.play()
	level_selected=5
	timer.start()

func _on_timer_timeout():
	if level_selected==1 :
		get_tree().change_scene_to_file("res://Scenes/level1.tscn")
	if level_selected==2 :
		get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
	if level_selected==3 :
		get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
	if level_selected==4 :
		get_tree().change_scene_to_file("res://Scenes/level_4.tscn")
	if level_selected==5 :
		get_tree().change_scene_to_file("res://Scenes/level_5.tscn")
	
