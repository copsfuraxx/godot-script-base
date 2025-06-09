class_name AnimatedComponent
extends Node

@export var animated_properties: Array[AnimatedPropertie]


func _ready() -> void:
	var parent := get_parent()
	for ap in animated_properties:
		ap.make_tween(parent)
