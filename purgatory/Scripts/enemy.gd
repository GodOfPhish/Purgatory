extends CharacterBody3D

# Movement stuff
var spd : float = 4.0
var grav : float = 0.15
@onready var ray : RayCast3D = $RayCast

# Attack stuff
var bullet = preload("res://Scenes/enemy_bullet.tscn")
var atk_time = 120
var atk_timer = 0
var bullet_spd = 0.1
var bullet_dmg = 10


func _ready() -> void:
	atk_timer = atk_time

func _physics_process(_delta) -> void:
	if atk_timer >= 0:
		atk_timer -= 1
		if atk_timer <= 0:
			var new_bullet = bullet.instantiate()
			new_bullet.dir = global_position.direction_to(Global.player.global_position).normalized()
			new_bullet.spd = bullet_spd
			new_bullet.dmg = bullet_dmg
			add_sibling(new_bullet)
			new_bullet.global_position = Vector3(global_position.x, global_position.y, global_position.z)
			atk_timer = atk_time
	
	# Find if colliding with the floor
	if !is_on_floor():
		# If not on the floor, check height above ground
		if !ray.is_colliding():
			velocity.y -= grav
		else:
			velocity.y = 0
	
	if global_position.distance_to(Global.player.global_position) >= 5:
		# Find direction if 
		var direction := global_position.direction_to(Global.player.global_position).normalized()
		velocity.x = direction.x * spd * Global.dtime
		velocity.z = direction.z * spd * Global.dtime
	else:
		velocity.x = move_toward(velocity.x, 0, spd)
		velocity.z = move_toward(velocity.z, 0, spd)

	move_and_slide()
