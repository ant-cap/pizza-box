extends Control

signal menu_closed
signal decrement_players
signal increment_players

func _on_play_button_pressed() -> void:
	self.hide()
	emit_signal("menu_closed")

func _on_minus_button_pressed() -> void:
	emit_signal("decrement_players")

func _on_plus_button_pressed() -> void:
	emit_signal("increment_players")
