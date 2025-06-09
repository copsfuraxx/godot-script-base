class_name Player
extends CharacterBody2D

var speed := 300.0
var jump_velocity := -300.0

var _state : State

var states : Dictionary

@onready
var animation : AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	states = Dictionary()
	for child in $States.get_children():
		states[child.name] = child
		child.player = self


func change_state(new_state : String) -> void:
	if not _state._can_enter_state(new_state):
		return
	_state._exit_state()
	_state = states[new_state]
	_state._enter_state()


func move() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		animation.flip_h = direction < 0
	else :
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()
