extends State


func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * 1.5 * delta
		player.move()
	else:
		player.change_state("IdleState")


func _enter_state() -> void:
	player.animation.animation = "fall"
	set_physics_process(true)


func _exit_state() -> void:
	set_physics_process(false)
