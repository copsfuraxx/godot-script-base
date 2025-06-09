extends AudioStreamPlayer

## This script extends the [AudioStreamPlayer] node to handle background music playback 
## with features for adjusting and saving music volume and mute status. The script uses 
## a configuration handler (autoloads/config_handler.gd) to store these settings, ensuring they 
## persist across game sessions.[br]
## Use it as an Autloload

## Key for storing the music volume.
const VOLUME := "music_volume"
## Key for storing the mute status.
const MUTE := "is_music_mute"

## Variable to keep track of whether the music is muted.
var is_music_mute := false

## Initializes settings and connections.
func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	if ConfigHandler.has_sound_key(VOLUME):
		volume_db = ConfigHandler.get_sound_value(VOLUME)
	else:
		ConfigHandler.set_sound_value(VOLUME, volume_db)
	if ConfigHandler.has_sound_key(MUTE):
		is_music_mute = ConfigHandler.get_sound_value(MUTE)
	else:
		ConfigHandler.set_sound_value(MUTE, is_music_mute)

## Plays the provided [param music], applying the current mute status.
func play_music(music: AudioStream) -> void:
	stream = music
	play()
	stream_paused = is_music_mute

## Sets the music [param volume] and saves it in the configuration.[br][br]
## [b]Note:[/b] the [param volume] is in decibels.
func set_music_volume(volume: float) -> void:
	volume_db = volume
	ConfigHandler.set_sound_value(VOLUME, volume_db)

## Sets the [param mute] status and saves it in the configuration.
func set_mute(value: bool) -> void:
	is_music_mute = value
	if value:
		stop()
	else:
		play()
	ConfigHandler.set_sound_value(MUTE, value)
