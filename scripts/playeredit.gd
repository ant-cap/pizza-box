extends HBoxContainer

@onready var colorButton: ColorPickerButton = $ColorPickerButton
@onready var nameInput: LineEdit = $LineEdit

func _on_color_picker_button_picker_created() -> void:
	var picker = colorButton.get_picker()
	picker.set_color_mode(ColorPicker.MODE_RGB)
	picker.set_picker_shape(ColorPicker.SHAPE_HSV_WHEEL)
	picker.set_can_add_swatches(false)
	picker.set_modes_visible(false)
	picker.set_presets_visible(false)
	picker.set_sampler_visible(false)
	picker.set_hex_visible(false)

func setColor(color: Color) -> void:
	colorButton.set_pick_color(color)

func setName(editName: String) -> void:
	nameInput.text = editName
