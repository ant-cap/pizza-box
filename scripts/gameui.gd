extends Control

@onready var currentPlayerTurnLabel = $Control/CurrentPlayerTurn

func setPlayerTurn(playerName: String) -> void:
	currentPlayerTurnLabel.text = "%s" % playerName
