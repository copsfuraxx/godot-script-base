extends CanvasLayer
## Use it as an Autoload

var paused := false:
	set(value):
		paused = value
		pause_screen.visible = paused
		if paused:
			# Make the mouse visible, focus the resume button and pause the tree.
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			resume_button.grab_focus()
			# This menu ignores pause mode so it can still be used.
			get_tree().paused = true
		else:
			# Capture the mouse and unpause the game.
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().paused = false

@onready var pause_screen: Control = $PauseScreen
@onready var pause_container: CenterContainer = %PauseContainer
@onready var settings_container: CenterContainer = %SettingsContainer
@onready var resume_button: Button = %ResumeButton
@onready var color_rect_fader: ColorRect = $ColorRectFader


func _ready() -> void:
	fade_in(create_tween())


func _on_resume_button_pressed() -> void:
	paused = false


func _on_settings_button_pressed() -> void:
	pause_container.visible = false
	settings_container.visible = true
	settings_container.focus()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_settings_container_exit() -> void:
	pause_container.visible = true
	settings_container.visible = false
	resume_button.grab_focus()

# Take an existing tween and add steps to fade the screen in.
func fade_in(tween_in: Tween):
	tween_in.tween_property(color_rect_fader, "color:a", 0.0, 0.5)
	tween_in.tween_callback(func(): color_rect_fader.visible = false)

# Take an existing tween and add steps to fade the screen out.
func fade_out(tween_in: Tween):
	color_rect_fader.visible = true
	tween_in.tween_property(color_rect_fader, "color:a", 1.0, 0.25).from(0.0)

# Fade the screen out, change level and fade back in.
func change_scene(next_scene: String) -> void:
	var tween = create_tween()
	fade_out(tween)
	tween.tween_callback(func(): get_tree().change_scene_to_file(next_scene))
	# Wait at least one frame for the scene to update and ready.
	tween.tween_interval(0.1)
	fade_in(tween)