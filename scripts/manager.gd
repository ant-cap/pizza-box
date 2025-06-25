extends Node

@export var numPlayers: int = 2
var players: Array
var currentPlayer: int = 0

func _ready() -> void:
	$UI/Menu.connect("menu_closed", Callable(self, "init_game"))
	$UI/Menu/NumPlayers.text = str(numPlayers)

func init_game() -> void:
	var player_scene = preload("res://scenes/player.tscn")
	for i in range(numPlayers):
		var player = player_scene.instantiate()
		player.name = "Player %s" % i
		players.append(player)
		$Players.add_child(player)
	move_camera_to(Vector3(0, 1, -1), $Camera3D.rotation, 1.0)
	
	$UI/Gameui/Control/CurrentPlayerTurn.text = "%s's Turn" % players[currentPlayer].name

# CAMERA SHIT
func move_camera_to(pos: Vector3, rot: Vector3, duration: float):
	var tween = create_tween()
	tween.tween_property($Camera3D, "position", pos, duration)
	tween.tween_property($Camera3D, "rotation", rot, duration)
