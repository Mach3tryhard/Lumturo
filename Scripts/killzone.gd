extends Area2D

@onready var timer = $Timer

#TRIGGER KILL ANIMATION ON PLAYER AND LEVEL RESET
func _on_body_entered(body):
	print("You died!")
	body.visible=false
	body.visible=true
	timer.start()

#RELOAD LEVEL
func _on_timer_timeout():
	get_tree().reload_current_scene()
