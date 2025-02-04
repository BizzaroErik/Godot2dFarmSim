class_name Chicken
extends NonPlayableCharacter

@onready var state_machine: Node = $state_machine
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
#@onready var hit_component: Hitable = $Hitable
var look_dir: Vector2 = Vector2.ZERO

func _ready():
	walk_cycles = randi_range(min_walk_cycle, max_walk_cycle)
	state_machine.init(self, sprite)

func _unhandled_input(event):
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
