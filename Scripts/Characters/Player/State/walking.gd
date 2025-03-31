extends State

@export var idle_state: State
@export var jumping_state: State

var movement_sound = preload("res://Scenes/Audio/SandSteps.tscn")
var movement_sound_timer = preload("res://Scenes/Components/AudioPlayTimer.tscn")
var loaded_sound: AudioStreamPlayer2D
var sound_timer: AudioPlayTimer
const WALK_SPEED = 5.0
const SPRINT_SPEED = 10.0
const SPEED = 70.0
const JUMP_VELOCITY = 6.5


func enter() -> void:
	set_animation(character.look_dir)
	set_audio()
	

func exit() -> void:
	sprite.stop()
	loaded_sound.stop()
	loaded_sound.queue_free()
	sound_timer.queue_free()

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	var input_dir = _get_input_direction()
	character.velocity = input_dir * SPEED
	if character.look_dir != input_dir && input_dir != Vector2.ZERO:
		set_animation(input_dir)
		character.look_dir = input_dir
	character.move_and_slide()
	
	if character.velocity == Vector2.ZERO:
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
			
func set_audio() -> void:
	loaded_sound = movement_sound.instantiate() as AudioStreamPlayer2D
	sound_timer = movement_sound_timer.instantiate() as AudioPlayTimer
	get_parent().add_child(loaded_sound)
	get_parent().add_child(sound_timer)
	sound_timer.set_audio_stream_player(loaded_sound)
	sound_timer.wait_time = 0.4
	sound_timer.start()
