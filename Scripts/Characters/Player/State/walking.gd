extends State

@export var idle_state: State
@export var jumping_state: State

const WALK_SPEED = 5.0
const SPRINT_SPEED = 10.0
const SPEED = 70.0
const JUMP_VELOCITY = 6.5


func enter() -> void:
	set_animation(player.look_dir)

func exit() -> void:
	sprite.stop()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var input_dir = _get_input_direction()
	player.velocity = input_dir * SPEED
	if player.look_dir != input_dir && input_dir != Vector2.ZERO:
		set_animation(input_dir)
		player.look_dir = input_dir
	player.move_and_slide()
	
	if player.velocity == Vector2.ZERO:
		return idle_state
	else:
		return null

func _get_input_direction():
	var input_dir := Input.get_vector("left", "right", "up", "down").normalized()
	set_animation(input_dir)
	return input_dir

func set_animation(direction) -> void:
	match direction:
		Vector2.UP:
			sprite.play("walk_back")
		Vector2.DOWN:
			sprite.play("walk_front")
		Vector2.LEFT:
			sprite.play("walk_left")
		Vector2.RIGHT:
			sprite.play("walk_right")
