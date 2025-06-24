extends Control

signal menu_closed

func _on_play_button_pressed() -> void:
	self.hide()
	emit_signal("menu_closed")
