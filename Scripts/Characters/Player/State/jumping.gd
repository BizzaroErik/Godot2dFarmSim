extends State

@export var idle_state: State
@export var walking_state: State
var speed = 5.0
const JUMP_VELOCITY = 6.5
var jump_direction: Vector3
var can_jump: bool = true

func enter() -> void:
	pass
func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
