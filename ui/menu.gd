extends Control

@export
var game_scene: PackedScene
@export
var music_menu: AudioStream

@onready
var menu: Control = $Menu
@onready
var parameters: Control = $SettingsContainer
@onready
var credits: Control = $Credits


func  _ready() -> void:
	MusicHandler.play_music(music_menu)


func _on_play_button_pressed() -> void:
	UserInterface.change_scene(game_scene)


func _on_parameters_button_pressed() -> void:
	menu.visible = false
	parameters.visible = true


func _on_credits_button_pressed() -> void:
	menu.visible = false
	credits.visible = true


func _on_return_pressed() -> void:
	parameters.visible = false
	credits.visible = false
	menu.visible = true


func _on_rich_text_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)
