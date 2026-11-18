extends Area3D

# Movement variables
var spd
var dir

# Attack Variables
var dmg

func _process(_float) -> void:
	position.x += spd * dir.x
	position.y += spd * dir.y
	position.z += spd * dir.z

func _on_area_entered(area: Area3D) -> void:
	if area.get_parent().get_collision_layer_value(1):
		queue_free()

func _on_body_entered(body: StaticBody3D) -> void:
	if body.get_collision_layer_value(2):
		queue_free()
