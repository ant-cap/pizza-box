extends Node3D

@export var alias: String = ""
@export var color: Color = Color.TRANSPARENT

@onready var sphere: MeshInstance3D = $Sphere
@onready var label: Label3D = $Label3D

func _ready() -> void:
	var mat = StandardMaterial3D.new()
	mat.set_albedo(color)
	sphere.set_surface_override_material(0, mat)
	global_position = Vector3(0, 6, 0)
	
	label.text = alias

func _process(_delta: float) -> void:
	label.look_at(get_viewport().get_camera_3d().global_position)
	label.rotate_y(PI)
