extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Player.set_physics_process(false)
	$Player.start($StartPosition.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# HACK temporary
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
