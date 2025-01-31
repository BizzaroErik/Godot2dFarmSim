extends State

@export var walking_state: State
@export var jumping_state: State
@export var tilling_state: State
@export var chopping_state: State
@export var watering_state: State
@export var mining_state: State

const WALK_SPEED = 5.0
const SPRINT_SPEED = 10.0
var speed = 5.0
const JUMP_VELOCITY = 6.5

func enter() -> void:
	set_animation(player.look_dir)

func exit() -> void:
	sprite.stop()

func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed("action"):
		match player.hit_component.current_tool:
			DataTypes.Tools.TillGround:
				return tilling_state
			DataTypes.Tools.ChopWood:
				return chopping_state
			DataTypes.Tools.WaterCrops:
				return watering_state
			DataTypes.Tools.MineRock:
				return mining_state
			DataTypes.Tools.None:
				return null
			_:
				return null

	var input_dir := Input.get_vector("left", "right", "up", "down")
	if player.look_dir != input_dir && input_dir != Vector2.ZERO:
		set_animation(input_dir)
		player.look_dir = input_dir

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
