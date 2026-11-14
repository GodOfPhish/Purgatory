extends Node

# Delta Time
var dtime

# UI
var pause_menu : bool

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta: float) -> void:
	# Get dtime
	dtime = delta * 60.0
	
	# Pause if needed
	if pause_menu:
		get_tree().paused = true
	else:
		get_tree().paused = false
	
	# Debug quit
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
