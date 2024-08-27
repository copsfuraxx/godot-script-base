class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0


@export
var _state : State


@onready
var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready
var shape : CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	for child in $States.get_children():
		child.player = self
	_state._enter_state()


func change_state(new_state : String) -> void:
	_state._exit_state()
	_state = get_node("States/" + new_state)
	_state._enter_state()


func _move() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animation.flip_h = direction < 0
	else :
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
