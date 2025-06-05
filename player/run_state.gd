extends State

var is_exited : bool

func _physics_process(_delta: float) -> void:
	if is_exited:
		if Input.get_axis("move_left", "move_right") and player.is_on_floor():
			player.change_state("RunState")
		return
	if not player.is_on_floor():
		player.change_state("FallState")
		return
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * player.SPEED
		player.animation.flip_h = direction < 0
		player.move_and_slide()
	else:
		player.change_state("IdleState")


func _enter_state() -> void:
	is_exited = false
	player.animation.play("run")


func _exit_state() -> void:
	is_exited = true
