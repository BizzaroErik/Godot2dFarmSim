class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var state_machine: Node = $state_machine
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_component: Hitable = $Hitable
var look_dir: Vector2 = Vector2.ZERO

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	state_machine.init(self, sprite)

func _unhandled_input(event):
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
