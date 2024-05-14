extends Area2D

@onready var game_manager = %"Game Manager"
@onready var animation_player = $AnimationPlayer
@onready var point_light_2d = $PointLight2D
@onready var cpu_particles_2d = $CPUParticles2D
@onready var sound = $sound
@onready var collision_shape_2d = $CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var kill_timer = $kill_timer

#ADD Pick-up TO MANAGER
func _on_body_entered(_body):
	kill_timer.start()
	animated_sprite_2d.set_deferred("visible",false)
	collision_shape_2d.set_deferred("disabled",true)
	point_light_2d.set_deferred("enabled",false)
	cpu_particles_2d.set_deferred("visible",false)
	#point_light_2d.enabled=false
	#cpu_particles_2d.emitting=false
	#animated_sprite_2d.visible=false
	#collision_shape_2d.disabled=true
	sound.play()
	game_manager.add_point()

func _on_kill_timer_timeout():
	queue_free()
