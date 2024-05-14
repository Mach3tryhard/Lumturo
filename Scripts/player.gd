extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -260.0
var dead=0
var spawn=0
var doublejump=0
var coyotetime=0
var lastanimated=0
var was_on_floor = true 
var isgrounded = true
var won=0
var crouched=0

@onready var animated_sprite = $AnimatedSprite2D
@onready var audio_animations = $Audio_Animations
@onready var coyote_time = $Coyote_time
@onready var spawn_time = $Spawn_time
@onready var collision_shape_2d = $big_hitbox
@onready var small_hitbox = $small_hitbox

@onready var dust = preload("res://Scenes/dust.tscn")
@onready var doublejump_timer = $doublejumpTimer
@onready var marker_2d = $Marker2D
@onready var speedrun_timer = $"Speedrun timer"
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var speedrun_label = $CanvasLayer/Speedrun_label
@onready var spawn_sound = $spawn_sound

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	spawn_sound.play()
	spawn_time.start()

var seconds=0
#SPEEDRUN TIMER
func _process(_delta):
	if speedrun_timer.is_stopped() :
		speedrun_timer.start()
	var mseconds= 1 - snapped(speedrun_timer.time_left, 0.01)
	mseconds=str(mseconds)
	mseconds= mseconds.erase(0, 2)
	if mseconds.length()==0 :
		mseconds+="00"
	if mseconds.length()==1 :
		mseconds+="0"
	if won==0 :
		speedrun_label.text=str(seconds)+":"+mseconds

func _physics_process(delta):
	# GET INPUT DIRECTION
	var direction = Input.get_axis("move_left", "move_right")
	if Input.is_action_just_pressed("leave") :
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	#PLAY DUST ANIMATION
	if isgrounded==false && is_on_floor()==true:
		playdust("white")
		print("dust appear")
	isgrounded=is_on_floor()
	
	#ADD GRAVITY
	
	if not is_on_floor():
		if ((ray_cast_right.is_colliding() && direction==1) || (ray_cast_left.is_colliding() && direction==-1)) && velocity.y>0:
			velocity.y += gravity /10 * delta
		else :
			velocity.y += gravity* delta
			
	
	#ALIVE AND WELL
	if dead==0 && spawn==1 :
		
		if Input.is_action_just_pressed("jump") :
			#COYOTEE TIME AND NORMAL JUMP
			if is_on_floor() || (!coyote_time.is_stopped() && coyotetime==0 ):
				jump()
				playdust("white")
				doublejump_timer.start()
				coyotetime=1
				doublejump=0
				print("jump")
			#DOUBLE JUMP
			if !is_on_floor() && doublejump==0 && doublejump_timer.is_stopped():
				jump()
				audio_animations.play("dj_sound")
				playdust("red")
				doublejump=1
				print("doublejump")
			
			
		#FLIP SPRITE
		if direction>0 :
			animated_sprite.flip_h = false
		elif direction<0 :
			animated_sprite.flip_h = true
		
		if Input.is_action_just_pressed("crouch") :
			crouched=1
			collision_shape_2d.set_deferred("disabled",true)
			small_hitbox.set_deferred("disabled",false)
		if Input.is_action_just_released("crouch"):
			crouched=0
			collision_shape_2d.set_deferred("disabled",false)
			small_hitbox.set_deferred("disabled",true)
		if is_on_floor() :
			was_on_floor=0
			doublejump=0
			coyotetime=0
		
		#PLAY ANIMAIONS
		if crouched==1 :
			animated_sprite.play("crouch")
			lastanimated=0
		elif is_on_floor() :
			if direction==0:
				animated_sprite.play("idle")
				lastanimated=0
			elif direction!=0 :
				animated_sprite.play("run")
				lastanimated=0
		elif (ray_cast_right.is_colliding() && direction==1) || (ray_cast_left.is_colliding() && direction==-1) :
			animated_sprite.play("slide")
			lastanimated=0
		elif lastanimated==0 :
			animated_sprite.play("jumping")
			lastanimated=1
		
		#CHANGE DIRECTIONS
		if direction && crouched==0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		#STARTING COYOTEE TIME
		if was_on_floor==0 && !is_on_floor():
			was_on_floor=1
			if velocity.y>0:
				coyote_time.start()
				print("coyotee time")
			
	# ACTIVATE PHYSICS
	if dead==0:
		move_and_slide()

#DEAD
func _on_hidden() :
	if dead==0:
		animated_sprite.play("die")
		audio_animations.play("die_animation")
		print("animation played")
	dead=1
	
#SPAWN
func _on_spawn_time_timeout():
	spawn=1
	
#JUMP ANIMATIONS
func jump() :
	velocity.y = JUMP_VELOCITY
	audio_animations.play("jump_sound")
	animated_sprite.play("jumping")

func playdust(color):
	var instance = dust.instantiate()
	if(color=="red"):
		instance.modulate = Color("D95763",1)
	instance.global_position = marker_2d.global_position
	get_parent().add_child(instance)


func _on_speedrun_timer_timeout():
	seconds+=1
	print("+1")

func _on_canvas_layer_visibility_changed():
	won=1
