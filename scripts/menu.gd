extends Control

var edits: Array

@export var defaultColors: Array[Color] = [
	Color.RED, Color.BLUE, Color.GREEN, Color.YELLOW, Color.PURPLE, Color.ORANGE
]

signal menu_closed
signal decrement_players
signal increment_players
signal quit_game

@onready var playerInfoContainer: VBoxContainer = $Main/PlayerInfo/VBoxContainer

func setNumPlayers(numPlayers: int) -> void:
	$Main/PlayerInfo/VBoxContainer/NumPlayersLine/NumPlayers.text = "%s" % str(numPlayers)

func initPlayerEdits(numPlayers: int) -> void:
	var edit_scene = preload("res://scenes/playeredit.tscn")
	for i in range(numPlayers):
		var edit = edit_scene.instantiate()
		playerInfoContainer.add_child(edit)
		edit.setColor(defaultColors[i])
		edit.setName("Player %s" % str(i))
		edits.append(edit)
		
func adjustPlayerEdits(numPlayers: int) -> void:
	var prevNumPlayers = len(edits)
	if prevNumPlayers == numPlayers:
		return
	elif prevNumPlayers > numPlayers:
		for i in range(numPlayers, prevNumPlayers):
			edits[i].queue_free()
			edits.remove_at(i)
	elif prevNumPlayers < numPlayers:
		var edit_scene = preload("res://scenes/playeredit.tscn")
		for i in range(prevNumPlayers, numPlayers):
			var edit = edit_scene.instantiate()
			$Main/PlayerInfo/VBoxContainer.add_child(edit)
			edit.setColor(defaultColors[i])
			edit.setName("Player %s" % str(i))
			edits.append(edit)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if $Main.visible:
			get_tree().quit()
		if $Quit.visible:
			$Quit.hide()
		else:
			$Quit.show()

func _on_play_button_pressed() -> void:
	$Main.hide()
	$Quit.hide()
		
	var player_scene = preload("res://scenes/player.tscn")
	var players: Array = []
	for i in range(len(edits)):
		var player = player_scene.instantiate()
		player.alias = edits[i].getName()
		player.color = edits[i].getColor()
		players.append(player)
		
	emit_signal("menu_closed")


func _on_minus_button_pressed() -> void:
	emit_signal("decrement_players")

func _on_plus_button_pressed() -> void:
	emit_signal("increment_players")


func _on_yes_pressed() -> void:
	$Quit.hide()
	$Main.show()
	emit_signal("quit_game")
