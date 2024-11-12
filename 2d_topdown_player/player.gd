class_name Player
extends CharacterBody2D


const SPEED = 300.0


@export
var _state : State


var states : Dictionary


#@onready
#var animation : AnimatedSprite2D = $AnimatedSprite2D
#@onready
#var shape : CollisionShape2D = $CollisionShape2D


#func _ready() -> void:
	#states = Dictionary()
	#for child in $States.get_children():
		#states[child.name] = child
		#child.player = self
	#_state._enter_state()


func _physics_process(_delta):
	move()


func change_state(new_state : String) -> void:
	_state._exit_state()
	_state = states[new_state]
	_state._enter_state()


func move() -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_top", "move_bottom")
	if direction:
		velocity = direction * SPEED
		#animation.flip_h = direction.x < 0
	else :
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()
