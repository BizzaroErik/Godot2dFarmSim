extends State

@export var idle_state: State
@export var navigation_agent: NavigationAgent2D
@export var min_speed: float = 5.0
@export var max_speed: float = 10.0

var speed: float

func enter() -> void:
	print("why did the chicken walk into the fields")
	set_animation(character.look_dir)
	#calls method during idle time after the first physics frame, smoother nav setup of agent
	call_deferred("character_setup")

func exit() -> void:
	sprite.stop()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	if navigation_agent.is_navigation_finished():
		print("navigation is finished")
		character.velocity = Vector2.ZERO
		return idle_state
	
	var target_position: Vector2 = navigation_agent.get_next_path_position()
	var target_direction: Vector2 = character.global_position.direction_to(target_position)
	sprite.flip_h = target_direction.x < 0
	character.velocity = target_direction * speed
	character.move_and_slide()
	return null

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
		_:
			sprite.play("walk")

func character_setup() -> void:
	await get_tree().physics_frame
	set_movement_target()

func set_movement_target() -> void:
	var target_position: Vector2 = NavigationServer2D.map_get_random_point(navigation_agent.get_navigation_map(), navigation_agent.navigation_layers, false)
	navigation_agent.target_position = target_position
	speed = randf_range(min_speed, max_speed)
	
