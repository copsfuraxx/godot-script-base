@tool
class_name AnimatedPropertie
extends Resource


@export var path: String
@export var values: Array[Value]
@export var durations: Array[Duration]

var tween: Tween


func make_tween(node: Node) -> void:
	tween = node.create_tween()
	for i in values.size():
		tween.tween_property(node, path, values[i].value, durations[i].duration)
	tween.tween_callback(make_tween.bind(node))
