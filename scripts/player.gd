extends Node3D

@export var alias: String = ""
@export var color: Color = Color.TRANSPARENT

@onready var sphere: MeshInstance3D = $Sphere

func _ready() -> void:
	var mat = StandardMaterial3D.new()
	mat.set_albedo(color)
	sphere.set_surface_override_material(0, mat)
	global_position = Vector3(0, 6, 0)
