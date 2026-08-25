extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 130.0
const ROLL_SPEED = 150.0
const JUMP_VELOCITY = -300.0

var double_jump_counter = 0
var is_rolling = false
var roll_direction = 1.0

func _ready() -> void:
	animated_sprite.animation_finished.connect(_on_animation_finished)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
			
	# Roll state
	if is_rolling:
		velocity.x = roll_direction * ROLL_SPEED
		animated_sprite.play("roll")
		move_and_slide()
		return 
		
	# Start roll (only on floor)
	if Input.is_action_just_pressed("roll") and is_on_floor() and !is_rolling:
		start_roll()
		move_and_slide()
		return
		
	# Jump and double jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			double_jump_counter = 0
		elif double_jump_counter < 1:
			velocity.y = JUMP_VELOCITY
			double_jump_counter += 1
		
	# Horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	move_and_slide()
	
func start_roll() -> void:
	is_rolling = true
	# Lock direction based on current sprite flip state
	roll_direction = -1.0 if animated_sprite.flip_h else 1.0

func _on_animation_finished() -> void:
	if animated_sprite.animation == "roll":
		is_rolling = false
