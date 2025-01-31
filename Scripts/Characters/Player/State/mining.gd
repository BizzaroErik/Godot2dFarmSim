extends State

@export var idle_state: State
@export var hit_component_collision_shape: CollisionShape2D

func _ready() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0, 6)

func enter() -> void:
	set_animation()
	hit_component_collision_shape.disabled = false

func exit() -> void:
	sprite.stop()
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0, 6)

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	if !sprite.is_playing() and !Input.is_action_pressed("action"):
		return idle_state
	return null

func process_physics(delta: float) -> State:
	return null

func set_animation() -> void:
	match player.look_dir:
		Vector2.UP:
			sprite.play("chopping_back")
			hit_component_collision_shape.position = Vector2(0, -8)
		Vector2.DOWN:
			sprite.play("chopping_front")
			hit_component_collision_shape.position = Vector2(0, 10)
		Vector2.LEFT:
			sprite.play("chopping_left")
			hit_component_collision_shape.position = Vector2(-9, 6)
		Vector2.RIGHT:
			sprite.play("chopping_right")
			hit_component_collision_shape.position = Vector2(9, 6)
		_:
			sprite.play("chopping_front")
