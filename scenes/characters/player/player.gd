extends CharacterBody2D

var screen_size

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var swimming = false # Denotes whether the character is in water

func _ready():
	print("Hi from the player!")
	hide()
	
func start(pos):
	screen_size = get_viewport_rect()
	position = pos
	
	show()
	#$AnimatedSprite2D.play("male_cole_idle")

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):# and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		print("jumping!!")
		#$AnimatedSprite2D.play("male_cole_jump", 1.0, false)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
