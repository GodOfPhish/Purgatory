extends CharacterBody3D

# Onready variables
@onready var cam = $Camera
@onready var ray = $Camera/RayCast

# Movement stuff
const spd : float = 8.0
const jump_velocity : float = 4.5

# Interaction stuff
var target = null

# Camera stuff
var mouse_sensitivity = 0.1
func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.screen_relative.x * mouse_sensitivity
		cam.rotation_degrees.x -= event.screen_relative.y * mouse_sensitivity
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -90, 90)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(_delta) -> void:
	# Get possible interaction object
	if ray.is_colliding():
		target = ray.get_collider()
	else:
		target = null
	
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
