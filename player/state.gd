class_name State
extends Node


var player : Player


func _ready() -> void:
	_exit_state()


func _enter_state() -> void:
	pass


func _exit_state() -> void:
	pass


func _can_enter_state(_state: String) -> bool:
	return true
