extends AnimatedSprite2D

#DELETE DUST ANIMATION
func _on_animation_finished():
	queue_free()
