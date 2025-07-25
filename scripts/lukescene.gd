extends Node3D

var onBox = false
var shotFired = false
var targetPosition: Vector3
var startingPosition: Vector3
var debug_spheres := []  # To keep track of created spheres

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	startingPosition = $Quarter.global_position
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if onBox:
		targetPosition = get_mouse_position()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and shotFired == false and onBox:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var vel = launch_quarter(startingPosition, targetPosition, .25)
			print(vel)
			var body = $Quarter
			body.enable_gravity()
			body.linear_velocity = vel
			#body.apply_torque_impulse(Vector3(0,0,.05))
			shotFired = true
			
func _on_ground_mouse_entered() -> void:
	onBox = true
	
func _on_ground_mouse_exited() -> void:
	onBox = false

func get_mouse_position():
	var viewport := get_viewport()
	var mouse_position := viewport.get_mouse_position()
	var camera := viewport.get_camera_3d()

	var origin := camera.project_ray_origin(mouse_position)
	var direction := camera.project_ray_normal(mouse_position)
	var ray_length := 1000.0  # or a reasonable value for your world
	var end := origin + direction * ray_length

	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, end)

	# Optional: restrict to ground layer (e.g., 1)
	query.collision_mask = 1

	var result := space_state.intersect_ray(query)

	if result:
		print(result.position)
		return result.position
	else:
		print("No hit detected! Returning fallback.")
		return Vector3.ZERO  # or handle appropriately
	#draw_trajectory(mouse_position_3D)
	
func launch_quarter(start: Vector3, end: Vector3, apex_height: float) -> Vector3:
	var gravity: float = abs(ProjectSettings.get_setting("physics/3d/default_gravity")) # Usually 9.8
	var displacement: Vector3 = end - start
	var displacement_xz: Vector3 = Vector3(displacement.x, 0, displacement.z)
	
	var max_y = max(start.y, end.y)
	var apex_y = max_y + apex_height
	
	# Time to reach apex
	var time_to_apex: float = sqrt(2 * (apex_y - start.y) / gravity)
	# Vertical velocity needed to reach apex
	var initial_y_velocity: float = gravity * time_to_apex
	
	# Time from apex to target Y
	var time_from_apex: float = sqrt(2 * (apex_y - end.y) / gravity)
	var total_time: float = time_to_apex + time_from_apex
	
	# Horizontal velocity (constant)
	var horizontal_velocity: Vector3 = displacement_xz / total_time
	
	return horizontal_velocity + Vector3.UP * initial_y_velocity
	
##FUNCTIONS FOR DRAWING TRAJECTORY I COULD NOT FIGURE OUT
func _quadratic_bezier(p0: Vector3, p1: Vector3, p2: Vector3, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var r = q0.lerp(q1, t)
	return r
	
func draw_trajectory():
	var midpoint = (startingPosition + targetPosition)/2
	midpoint.y += 5
	
	var points = []
	var t = 0
	while t <= 1:
		var r = _quadratic_bezier(startingPosition, midpoint, targetPosition, t)
		points.append(r)
		t += .05
