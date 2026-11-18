extends Control

func _ready() -> void:
	# Hide self
	visible = false

func _process(_float) -> void:
	# Shows self and pauses game when called for
	if Input.is_action_just_pressed("exit"):
		if Global.pause_menu == true:
			Global.pause_menu = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Global.pause_menu = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	visible = Global.pause_menu

func _on_resume_pressed() -> void:
	# Resume
	Global.pause_menu = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_settings_pressed() -> void:
	pass # Make options later

func _on_quit_to_menu_pressed() -> void:
	pass # Make main menu later

func _on_quit_to_desktop_pressed() -> void:
	# Close game
	get_tree().quit()
