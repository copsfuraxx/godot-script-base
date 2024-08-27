extends TextureRect

@export
var next_sceen: PackedScene


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_go_next_screen()


func _go_next_screen() -> void:
	mouse_filter = MOUSE_FILTER_IGNORE
	$Timer.stop()
	UserInterface.change_scene(next_sceen)
