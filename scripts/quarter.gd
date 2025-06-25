extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravity_scale = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(position)
	
func enable_gravity():
	gravity_scale = 1
	

	
