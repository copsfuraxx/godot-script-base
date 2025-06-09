class_name AtlasToImageComponent
extends Node


@export var texture_var_name := "texture"


func _ready() -> void:
	var parent := get_parent()
	var atlas : AtlasTexture = parent.get(texture_var_name)
	var texture := ImageTexture.create_from_image(atlas.atlas.get_image().get_region(atlas.region))
	get_parent().set(texture_var_name, texture)
	queue_free()
