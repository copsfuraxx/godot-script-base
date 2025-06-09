@tool
class_name RandomDuration
extends Duration

@export var min_duration: float
@export var max_duration: float


func _add_duration_property(_properties: Array[Dictionary]) -> void:
	return


func _get_duration() -> float:
	return randf_range(min_duration, max_duration)
