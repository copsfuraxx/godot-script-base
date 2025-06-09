@tool
extends EditorScript


func _run() -> void:
	pass
	ProjectSettings.set_setting("display/window/size/viewport_width", 640)
	ProjectSettings.set_setting("display/window/size/viewport_height", 360)
	ProjectSettings.set_setting("display/window/size/window_width_override", 1152)
	ProjectSettings.set_setting("display/window/size/window_height_override", 648)
	ProjectSettings.set_setting("display/window/stretch/mode", "viewport")
	ProjectSettings.set_setting("display/window/stretch/scale_mode", "integer")
	ProjectSettings.set_setting("rendering/textures/canvas_textures/default_texture_filter", 0)
	ProjectSettings.save()
