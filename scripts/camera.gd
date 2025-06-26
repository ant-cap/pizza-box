extends Camera3D

@export var target: Vector3 = Vector3(0, 4, 0)
@export var distance: float = 5.0
@export var vertical_angle: float = 0.3  # Radians
@export var orbit_speed: float = 0.5     # Radians per second

var horizontal_angle: float = 0.0

func _process(delta):
	if target == null:
		return

	# Increment angle
	horizontal_angle += orbit_speed * delta

	# Compute new position
	var x = distance * cos(horizontal_angle) * cos(vertical_angle)
	var y = distance * sin(vertical_angle)
	var z = distance * sin(horizontal_angle) * cos(vertical_angle)
	
	global_position = target + Vector3(x, y, z)

	# Always face the target
	look_at(target, Vector3.UP)
