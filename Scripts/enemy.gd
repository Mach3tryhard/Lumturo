extends Node2D

const speed = 60
var direction = 1
const gravity = 98
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_down = $RayCastDown


func _process(delta):
	#APPLY GRAVITY TO ENEMY
	if not ray_cast_down.is_colliding():
		position.y+=gravity*delta
	
	#CHANGE DIRECTION IF IT HITS OBJECT
	if ray_cast_right.is_colliding():
		animated_sprite_2d.flip_h = true
		direction=-1
	if ray_cast_left.is_colliding(): 
		animated_sprite_2d.flip_h = false
		direction=1	
	#APPLY DIRECTION
	position.x+=direction * speed * delta
