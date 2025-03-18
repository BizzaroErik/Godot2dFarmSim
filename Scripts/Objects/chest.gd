extends Node2D

var balloon_scene = preload("res://Dialogue/game_dialogue_balloon.tscn")

var wheat_harvest_scene = preload("res://Scenes/Objects/Collectables/Wheat.tscn")

@export var dialoge_start_command: String
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
	interactable.hide()

func on_interactable_activated() -> void:
	interactable.show()
	in_range = true

func on_interactable_deactivated() -> void:
	interactable.hide()
	in_range = false
