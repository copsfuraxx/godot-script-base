@tool
class_name Duration
extends Resource

var duration: float: get=_get_duration


func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = [] 
	if Engine.is_editor_hint():
		_add_duration_property(properties)
	return properties


func _add_duration_property(properties: Array[Dictionary]) -> void:
	properties.append({
		"name": "duration",
		"type": TYPE_FLOAT,
	})


func _get_duration() -> float:
	return duration
