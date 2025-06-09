extends State

var is_jumping := false
var coyote_time: float = 0.0
var is_exited: bool


func _physics_process(delta: float) -> void:
	if is_exited:
		if Input.is_action_pressed("jump") and (coyote_time < 0.2 or player.is_on_floor()):
			coyote_time = 0.2
			player.change_state("JumpState")
		elif coyote_time < 0.2 and not player.is_on_floor():
			coyote_time += delta
		elif player.is_on_floor():
			coyote_time = 0.0
		return
	if not player.is_on_floor():
		if is_jumping:
			player.velocity += player.get_gravity() * 0.25 * delta
		else:
			player.velocity += player.get_gravity() * delta
		if player.velocity.y >= .0:
			player.change_state("FallState")
			return

	if is_jumping:
		if not Input.is_action_pressed("jump"):
			is_jumping = false

	player.move()


func _on_max_jump_timeout() -> void:
	is_jumping = false


func _enter_state() -> void:
	var sound := $JumpFX
	sound.pitch_scale = randf_range(0.8, 1.2)
	sound.play()
	is_exited = false
	player.animation.play("jump")
	player.animation.frame = 0
	$JumpTimer.start(0.5)
	player.velocity.y = player.jump_velocity
	is_jumping = true


func _exit_state() -> void:
	is_exited = true


func _can_enter_state(state: String) -> bool:
	if state == "RunState":
		return false
	return true
