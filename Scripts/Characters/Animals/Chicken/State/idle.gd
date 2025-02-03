extends State

@export var walking_state: State
@export var idle_state_time_interval: float = 5.0
@onready var idle_state_timer: Timer = Timer.new()

var idle_state_timeout: bool = false

func _ready() -> void:
	print("should only run once?")
	idle_state_timer.wait_time = idle_state_time_interval
	idle_state_timer.timeout.connect(on_idle_state_timeout)
	idle_state_timer.autostart = true
	add_child(idle_state_timer)
	
func enter() -> void:
	print("to get to the other side")
	set_animation(character.look_dir)
	idle_state_timeout = false
	idle_state_timer.start()

func exit() -> void:
	sprite.stop()
	idle_state_timer.stop()

func process_frame(delta: float) -> State:
	if idle_state_timeout:
		return walking_state
	else:
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
			print("played front idle for chicken")
			sprite.play("idle_front")

func on_idle_state_timeout() -> void:
	print("timer timeout again")
	idle_state_timeout = true
