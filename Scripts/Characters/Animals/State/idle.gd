extends State

@export var walking_state: State

const WALK_SPEED = 5.0
const SPRINT_SPEED = 10.0
var speed = 5.0
const JUMP_VELOCITY = 6.5

func enter() -> void:
	set_animation(character.look_dir)

func exit() -> void:
	sprite.stop()

func process_input(event: InputEvent) -> State:
	return null

	var input_dir := Input.get_vector("left", "right", "up", "down")
	if character.look_dir != input_dir && input_dir != Vector2.ZERO:
		set_animation(input_dir)
		character.look_dir = input_dir

	if input_dir != Vector2(0,0):
		return walking_state
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func set_animation(direction) -> void:
	match direction:
		Vector2.UP:
			sprite.play("idle_back")
		Vector2.DOWN:
			sprite.play("idle_front")
		Vector2.LEFT:
			sprite.play("idle_left")
		Vector2.RIGHT:
			sprite.play("idle_right")
		_:
			sprite.play("idle_front")
