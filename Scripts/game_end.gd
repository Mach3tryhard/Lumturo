extends Area2D

@onready var game_manager = %"Game Manager"
@onready var animation_player = $AnimationPlayer
@onready var end_timer = $End_Timer
@onready var game_ender = $"."

#ADD COIN TO MANAGER
func _on_body_entered(_body):
	print("end")
	end_timer.start()
	Engine.time_scale=0.25
	animation_player.play("pickup_animation")
	game_ender.set_deferred("visible",false)
	var control = _body.get_node("CanvasLayer")
	control.set_deferred("visible",false)
	control.set_deferred("visible",true)

func _on_end_timer_timeout():
	#ADD LEVEL ENDING ANIMATION
	Engine.time_scale=1
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
