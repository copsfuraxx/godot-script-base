extends State


func _physics_process(_delta: float) -> void:
	if not player.is_on_floor():
		player.change_state("FallState")
		return
	player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
	player.move_and_slide()


func _enter_state() -> void:
	player.animation.play("idle")
	set_physics_process(true)


func _exit_state() -> void:
	set_physics_process(false)
