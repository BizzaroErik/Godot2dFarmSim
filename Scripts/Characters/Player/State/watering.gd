extends State

@export var idle_state: State

func enter() -> void:
	set_animation()

func exit() -> void:
	sprite.stop()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	if !sprite.is_playing() and !Input.is_action_pressed("action"):
		return idle_state
	return null

func process_physics(delta: float) -> State:
	return null

func set_animation() -> void:
	match character.look_dir:
		Vector2.UP:
			sprite.play("watering_back")
		Vector2.DOWN:
			sprite.play("watering_front")
		Vector2.LEFT:
			sprite.play("watering_left")
		Vector2.RIGHT:
			sprite.play("watering_right")
		_:
			sprite.play("watering_front")
