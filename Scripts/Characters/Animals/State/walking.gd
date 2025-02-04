extends State

@export var idle_state: State
@export var navigation_agent: NavigationAgent2D
@export var min_speed: float = 5.0
@export var max_speed: float = 10.0
@onready var animal: CharacterBody2D = $"../.."

var speed: float

func enter() -> void:
	navigation_agent.velocity_computed.connect(on_safe_velocity_computed)
	set_animation()
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
		character.velocity = Vector2.ZERO
		if animal.walk_cycles >= animal.max_walk_cycle:
			return idle_state
		animal.walk_cycles += 1
	
	var target_position: Vector2 = navigation_agent.get_next_path_position()
	var target_direction: Vector2 = character.global_position.direction_to(target_position)
	
	var velocity = target_direction * speed
	
	if navigation_agent.avoidance_enabled:
		sprite.flip_h = velocity.x < 0
		navigation_agent.velocity = velocity
	else:
		character.velocity = velocity
		character.move_and_slide()
	
	return null

func set_animation() -> void:
	sprite.play("walk")

func character_setup() -> void:
	await get_tree().physics_frame
	set_movement_target()

func set_movement_target() -> void:
	var target_position: Vector2 = NavigationServer2D.map_get_random_point(navigation_agent.get_navigation_map(), navigation_agent.navigation_layers, false)
	navigation_agent.target_position = target_position
	speed = randf_range(min_speed, max_speed)
	
func on_safe_velocity_computed(safe_velocity: Vector2) -> void:
	sprite.flip_h = safe_velocity.x < 0
	character.velocity = safe_velocity
	character.move_and_slide()
