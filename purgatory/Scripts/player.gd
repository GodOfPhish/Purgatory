extends CharacterBody3D

# Onready variables
@onready var cam = $Camera
@onready var ray = $Camera/RayCast

# Movement stuff
var spd : float = 8.0
var jump_velocity : float = 4
var grav : float = 0.15

# Interaction stuff
var target = null

func _ready() -> void:
	Global.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Camera stuff
var mouse_sensitivity = 0.1
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.screen_relative.x * mouse_sensitivity
		cam.rotation_degrees.x -= event.screen_relative.y * mouse_sensitivity
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -90, 90)

func _physics_process(_delta) -> void:
	# Get possible interaction object
	if ray.is_colliding():
		target = ray.get_collider()
	else:
		target = null
	
	# Find if colliding with the floor
	if is_on_floor():
		# Find if the jump button is pressed
		if Input.is_action_just_pressed("jump"):
			# Add jump velocity
			velocity.y += jump_velocity
	else:
		# If not on the floor, subtract gravity
		velocity.y -= grav
	
	# Find direction
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * spd * Global.dtime
		velocity.z = direction.z * spd * Global.dtime
	else:
		velocity.x = move_toward(velocity.x, 0, spd)
		velocity.z = move_toward(velocity.z, 0, spd)

	move_and_slide()
