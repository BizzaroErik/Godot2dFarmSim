extends Node2D

var balloon_scene = preload("res://Dialogue/game_dialogue_balloon.tscn")

var wheat_harvest_scene = preload("res://Scenes/Objects/Collectables/Wheat.tscn")

@export var dialogue_start_command: String
@export var food_drop_height: int = 40
@export var reward_output_radius: int = 20
@export var output_reward_scenes: Array[PackedScene] = []

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var feed_component: FeedComponent = $FeedComponent
@onready var reward_marker: Marker2D = $RewardMarker
@onready var interactable_label: Control = $InteractableLabel
@onready var interactable: Interactable = $Interactable

var in_range: bool
var is_chest_open: bool

func _ready() -> void:
	print("started chest scripts")
	interactable.interactable_activated.connect(on_interactable_activated)
	interactable.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label.hide()

func on_interactable_activated() -> void:
	interactable_label.show()
	in_range = true

func on_interactable_deactivated() -> void:
	interactable_label.hide()
	in_range = false
	
	if is_chest_open:
		animated_sprite_2d.play("chest_closed")
		is_chest_open = false

func _unhandled_input(event: InputEvent) -> void:
	if in_range and event.is_action_pressed("show_dialogue"):
		interactable_label.hide()
		animated_sprite_2d.play("chest_open")
		is_chest_open = true
		
		#create dialogue
		var balloon: BaseDialogueTestScene = balloon_scene.instantiate()
		balloon.position = reward_marker.position
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("some dialoague script file here"), dialogue_start_command)
		
		
