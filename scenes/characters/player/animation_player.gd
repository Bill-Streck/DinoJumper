extends AnimationPlayer

func _process(delta: float) -> void:
	# TODO check assigned animation?
	if Input.is_action_pressed("jump") and assigned_animation != "male_cole_idle":
		play("male_cole_idle")
		print("jump animation playing")
