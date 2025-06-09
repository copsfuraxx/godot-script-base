class_name InputSetter
extends Control

@warning_ignore("unused_signal")
signal done

@export var actions : Array[String]

var step : int


func _ready() -> void:
	var input_label := Label.new()
	input_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	input_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	for action in actions:
		var label := input_label.duplicate()
		label.name = "Input" + action_to_node(action)
		label.text = "PRESS_" + action.to_upper()
		add_child(label)
	_reset()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.pressed or step == actions.size():
		return
	InputMap.action_add_event(actions[step], event)
	%ValidateLabel.text += "%s => [%s]" % [tr(actions[step].to_upper()), event.as_text_key_label()]
	get_node("Input" + action_to_node(actions[step])).visible = false
	if step < actions.size() - 1:
		get_node("Input" + action_to_node(actions[step + 1])).visible = true
		%ValidateLabel.text += "\n"
	else:
		%ValidateContainer.visible = true
	step += 1


func _reset() -> void:
	step = 0
	%ValidateLabel.text = ""
	for action in actions:
		InputMap.action_erase_events(action)
	for child in get_children():
		child.visible = false
	get_node("Input" + action_to_node(actions[0])).visible = true


func action_to_node(action: String) -> String:
	return action.capitalize().replace(" ", "")
