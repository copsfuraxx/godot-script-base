extends CanvasLayer
## Use it as an Autoload

var paused := false:
	set(value):
		paused = value
		pause_screen.visible = paused
		if paused:
			resume_button.grab_focus()
		get_tree().paused = value

@onready var pause_screen: Control = $PauseScreen
@onready var pause_container: CenterContainer = %PauseContainer
@onready var settings_container: CenterContainer = %SettingsContainer
@onready var resume_button: Button = %ResumeButton
@onready var color_rect_fader: ColorRect = $ColorRectFader


func _ready() -> void:
	fade_in(create_tween())


func _unhandled_key_input(event: InputEvent) -> void:
	if paused and event.is_action_released("ui_cancel"):
		get_viewport().set_input_as_handled()
		paused = false


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
func fade_in(tween_in: Tween) -> void:
	tween_in.tween_property(color_rect_fader, "color:a", 0.0, 0.5)
	await tween_in.finished
	color_rect_fader.visible = false

# Take an existing tween and add steps to fade the screen out.
func fade_out(tween_in: Tween) -> void:
	color_rect_fader.visible = true
	tween_in.tween_property(color_rect_fader, "color:a", 1.0, 0.25).from(0.0)

# Fade the screen out, change level and fade back in.
func change_scene(next_scene: PackedScene) -> void:
	var tween := create_tween()
	fade_out(tween)
	await tween.finished
	get_tree().change_scene_to_packed(next_scene)
	await get_tree().process_frame
	tween = create_tween()
	fade_in(tween)
