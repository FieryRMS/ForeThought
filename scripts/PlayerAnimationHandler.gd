extends AnimationPlayer


func _process(_delta):
	if not get_parent().is_on_floor():
		if get_parent().Velocity.x > 0:
			play("InAirR_anim")
		elif get_parent().Velocity.x < 0:
			play("InAirL_anim")
		else:
			play("InAir_anim")
	elif Input.get_action_strength("move_left"):
		play("runningL_anim")
	elif Input.get_action_strength("move_right"):
		play("runningR_anim")
	else:
		play("idle_anim")
