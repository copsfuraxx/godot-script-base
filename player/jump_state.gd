extends State


var is_jumping := false
var is_gonna_jump := false

var is_exited : bool

func _physics_process(delta: float) -> void:
	if is_exited:
		if Input.is_action_pressed("jump") and player.is_on_floor():
			player.change_state("JumpState")
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

	if not is_gonna_jump:
		player.move()
	else:
		player.velocity.x = .0
		player.move_and_slide()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		player.change_state("JumpState")


func _on_jump_timer_timeout() -> void:
	var timer : Timer = $Timer
	timer.timeout.disconnect(_on_jump_timer_timeout)
	timer.timeout.connect(_on_max_jump_timeout)
	timer.start(0.5)
	player.velocity.y = player.JUMP_VELOCITY
	is_gonna_jump = false
	is_jumping = true


func _on_max_jump_timeout() -> void:
	$Timer.timeout.disconnect(_on_max_jump_timeout)
	is_jumping = false


func _enter_state() -> void:
	is_exited = false
	player.animation.play("jump")
	player.animation.frame = 0
	is_gonna_jump = true
	is_jumping = false
	var timer : Timer = $Timer
	timer.timeout.connect(_on_jump_timer_timeout)
	timer.start(0.2)
	


func _exit_state() -> void:
	is_exited = true
	var timer : Timer = $Timer
	for connection : Dictionary in timer.timeout.get_connections():
		timer.timeout.disconnect(connection.callable)


func _can_enter_state(state: String) -> bool:
	if state == "RunState":
		return false
	return true
