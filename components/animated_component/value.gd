@tool
class_name Value
extends Resource

@export var _type: Variant.Type:
	set(new_type):
		_type = new_type
		value = convert(0, _type)
		notify_property_list_changed()

var value: Variant: get=_get_value


func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = [] 
	if Engine.is_editor_hint():
		if _type:
			_add_value_property(properties)
	return properties


func _add_value_property(properties: Array[Dictionary]) -> void:
	properties.append({
		"name": "value",
		"type": _type,
	})


func _get_value() -> Variant:
	return value
