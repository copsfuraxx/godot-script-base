extends TextureRect


const ANIMATION := "default"


var time := .0
var frame := 0


@export
var sprite_frames : SpriteFrames


func _ready() -> void:
	texture = sprite_frames.get_frame_texture(ANIMATION, frame)


func _process(delta: float) -> void:
	time += delta
	if time > sprite_frames.get_frame_duration(ANIMATION, frame) / sprite_frames.get_animation_speed(ANIMATION):
		frame = (frame + 1) % sprite_frames.get_frame_count(ANIMATION)
		texture = sprite_frames.get_frame_texture(ANIMATION, frame)
		time = .0
