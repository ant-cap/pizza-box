extends Node

@export var numPlayers: int = 2
var players: Array
var currentPlayer: int = 0

@onready var menu = $UI/Menu
@onready var numPlayersText: Label = $UI/Menu/PlayerInfo/VBoxContainer/NumPlayersLine/NumPlayers
@onready var gameui = $UI/Gameui

func _ready() -> void:
	menu.connect("menu_closed", Callable(self, "init_game"))
	menu.connect("decrement_players", Callable(self, "dec_players"))
	menu.connect("increment_players", Callable(self, "inc_players"))
	
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
	
	gameui.show()
	gameui.setPlayerTurn(players[currentPlayer].alias)
	
func dec_players() -> void:
	if numPlayers < 2:
		return
	numPlayers -= 1
	numPlayersText.text = "%s" % str(numPlayers)
	menu.adjustPlayerEdits(numPlayers)
	
func inc_players() -> void:
	if numPlayers > 5:
		return
	numPlayers += 1
	numPlayersText.text = "%s" % str(numPlayers)
	menu.adjustPlayerEdits(numPlayers)


# CAMERA SHIT
func move_camera_to(pos: Vector3, rot: Vector3, duration: float):
	var tween = create_tween()
	tween.tween_property($Camera3D, "position", pos, duration)
	tween.tween_property($Camera3D, "rotation", rot, duration)
