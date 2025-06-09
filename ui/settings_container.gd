extends Control

signal return_clicked

@onready
var music_slider: Slider = %MusicSlider
@onready
var music_checkbox: CheckButton = %MusicCheckBox


func  _ready() -> void:
	music_slider.value = db_to_linear(MusicHandler.volume_db) * 100.0
	music_checkbox.button_pressed = MusicHandler.is_music_mute


func _on_music_slider_value_changed(changed: bool) -> void:
	if changed:
		MusicHandler.set_music_volume(linear_to_db(music_slider.value / 100.0))
	


func _on_music_check_box_toggled(toggled_on: bool) -> void:
	MusicHandler.set_mute(toggled_on)


func _on_return_pressed() -> void:
	return_clicked.emit()


func give_focus() -> void:
	%MusicSlider.grab_focus()
