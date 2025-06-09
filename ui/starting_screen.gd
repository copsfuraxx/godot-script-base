extends TextureRect

@export
var next_sceen: PackedScene


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_go_next_screen()


func _go_next_screen() -> void:
	process_mode = PROCESS_MODE_DISABLED
	UserInterface.change_scene(next_sceen)
