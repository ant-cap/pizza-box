extends Node

@export var numPlayers: int = 2

var players: Array[Node3D]
var currentPlayer: int = 0

var center: Vector3 = Vector3(0, 6, 0)
var radius: float = 4.5

@onready var menu = $UI/Menu
@onready var gameui = $UI/Gameui

@onready var menuCam: Camera3D = $MenuCamera
@onready var gameCam: Camera3D = $GameCamera

func _ready() -> void:
	menu.connect("menu_closed", Callable(self, "init_game"))
	menu.connect("decrement_players", Callable(self, "dec_players"))
	menu.connect("increment_players", Callable(self, "inc_players"))
	menu.connect("quit_game", Callable(self, "clear_game"))
	
	menu.initPlayerEdits(numPlayers)

func init_game() -> void:
	var player_scene = preload("res://scenes/player.tscn")
	var edits = menu.edits
	for i in range(numPlayers):
		var player = player_scene.instantiate()
		player.alias = edits[i].getName()
		player.color = edits[i].getColor()
		players.append(player)
		$Players.add_child(player)
	#move_camera_to(Vector3(0, 1, -1), $Camera3D.rotation, 1.0)
	currentPlayer = 0
	
	gameui.show()
	gameui.setPlayerTurn(players[currentPlayer].alias)
	position_players()
	gameCam.set_current(true)
	
func clear_game() -> void:
	for player in players:
		player.queue_free()
	players = []
	menuCam.set_current(true)
	
func position_players() -> void:
	var n := players.size()
	for i in range(n):
		var angle := -(2.0 * PI * i) / n
		var x := center.x + radius * cos(angle)
		var z := center.z + radius * sin(angle)
		var position := Vector3(x, center.y, z)
		players[i].global_position = position
		players[i].look_at(center, Vector3.UP)
	
func dec_players() -> void:
	if numPlayers < 2:
		return
	numPlayers -= 1
	menu.setNumPlayers(numPlayers)
	menu.adjustPlayerEdits(numPlayers)
	
func inc_players() -> void:
	if numPlayers > 5:
		return
	numPlayers += 1
	menu.setNumPlayers(numPlayers)
	menu.adjustPlayerEdits(numPlayers)

# CAMERA SHIT
func move_camera_to(pos: Vector3, rot: Vector3, duration: float):
	var tween = create_tween()
	tween.tween_property($Camera3D, "position", pos, duration)
	tween.tween_property($Camera3D, "rotation", rot, duration)
