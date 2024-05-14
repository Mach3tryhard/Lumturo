extends Node

var score = 0
@onready var player = %Player
@onready var timer = $Timer
@onready var score_label = $Score_Label

# ADD POINTS
func add_point() :
	score+=1
	player.get_node("Score_label").text = "+1"
	timer.start()
	score_label.text="You collected "+str(score)+"/10 lamps."
	print(score)

# REMOVE +1
func _on_timer_timeout():
	player.get_node("Score_label").text = ""
	
