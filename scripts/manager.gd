extends Node

@export var numPlayers: int = 2

func _ready() -> void:
	$UI/Menu.connect("menu_closed", Callable(self, "_on_menu_closed"))
	$UI/Menu/NumPlayers.text = str(numPlayers)

func _on_menu_closed() -> void:
	move_camera_to(Vector3(0, 1, -1), $Camera3D.rotation, 1.0)

# CAMERA SHIT

func move_camera_to(pos: Vector3, rot: Vector3, duration: float):
	var tween = create_tween()
	tween.tween_property($Camera3D, "position", pos, duration)
	tween.tween_property($Camera3D, "rotation", rot, duration)
