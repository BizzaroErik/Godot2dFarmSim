extends Node2D

var balloon_scene = preload("res://Dialogue/game_dialogue_balloon.tscn")

var wheat_harvest_scene = preload("res://Scenes/Objects/Collectables/Wheat.tscn")

@export var dialogue_start_command: String
@export var food_drop_height: int = 20
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
	interactable.interactable_activated.connect(on_interactable_activated)
	interactable.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label.hide()
	
	GameDialogueManager.feed_the_animals.connect(on_feed_the_animals)
	feed_component.food_received.connect(on_food_received)

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
		var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://Dialogue/Convos/chest.dialogue"), dialogue_start_command)
		
func on_feed_the_animals() -> void:
	if in_range:
		trigger_feed_harvest("wheat", wheat_harvest_scene)

func trigger_feed_harvest(inventory_item: String, scene: Resource) -> void:
	
	var inventory: Dictionary = InventoryManager.inventory
	if !inventory.has(inventory_item):
		return
	
	var inventory_item_count = inventory[inventory_item]
	
	for index in inventory_item_count:
		var wheat = wheat_harvest_scene.instantiate() as Node2D	
		wheat.global_position = Vector2(global_position.x, global_position.y - food_drop_height)
	
		get_tree().root.add_child(wheat)
	
		var target_position = global_position
		var time_delay = randf_range(0.5, 1.0)
		await get_tree().create_timer(time_delay).timeout
	
		var tween = get_tree().create_tween()
		tween.tween_property(wheat, "position", target_position, 0.5)
		tween.tween_property(wheat, "scale", Vector2(0.5, 0.5), 0.5)
		tween.tween_callback(wheat.queue_free)
		
		InventoryManager.remove_collectable(inventory_item)
	
func on_food_received(area: Area2D) -> void:
	call_deferred("add_reward_scene")

func add_reward_scene() -> void:
	for scene in output_reward_scenes:
		var reward_scene: Node2D = scene.instantiate()
		var reward_position = get_random_position_in_circle(reward_marker.global_position, reward_output_radius)
		reward_scene.global_position = reward_position
		get_tree().root.add_child(reward_scene)
	
func get_random_position_in_circle(center: Vector2, radius: int) -> Vector2i:
	var angle = randf() * TAU
	var distance_from_center = sqrt(randf()) * radius
	
	var x: int = center.x + distance_from_center * cos(angle)
	var y: int = center.y + distance_from_center * cos(angle)
	
	return Vector2i(x, y)
	
	
	
