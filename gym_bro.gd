extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var skeleton = $Bro 


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimationPlayer.speed_scale = 1.25
		$AnimationPlayer.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.speed_scale = 1.0
		$AnimationPlayer.play("idle")
		
	if direction > 0:
		skeleton.scale.x = 1 # Facing right
	elif direction < 0:
		skeleton.scale.x = -1 # Facing left
	
	
	move_and_slide()
