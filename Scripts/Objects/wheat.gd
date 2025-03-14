extends Node2D

#ToDo: Grid layout for crop placement
#ToDo: Implement finite state machine as well as customizable fields
#ToDo: Y-Sort based on state
#Fields: watered, 
#States: Seed, Growing, Producing, Harvest
#Flow: Corn: Seed -> Growing (2 days as small, 1 day as medium height, 3 days as tall) -> Producing (Every 3rd day)
#Flow2: Melon: Seed -> Growing (...) -> Harvest (days until rotten, unwatered, etc)
#Seed: Does nothing
#Growing: Animation params for growth, time for each animation, total time until producing/havest, producing
#Producing: Re-Producable crops like corn, tomatoes, grapes that produce a harvestable every x amount of days
#Harvest: Single Producable crops like a melon,
var wheat_harvest_scene = preload("res://Scenes/Objects/Collectables/Wheat.tscn")
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var watering_particles: GPUParticles2D = $WateringParticles
@onready var flowering_particles: GPUParticles2D = $FloweringParticles
@onready var growth_cycle: GrowthCycle = $GrowthCycle
@onready var hurtable: Hurtable = $Hurtable

var growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Seed
@export var start_frame: int

func _ready() -> void:
	watering_particles.emitting = false
	flowering_particles.emitting = false
	hurtable.hurt.connect(on_hurt)
	growth_cycle.crop_maturity.connect(on_crop_maturity)
	growth_cycle.crop_harvesting.connect(on_crop_harvesting)

func _process(delta: float) -> void:
	growth_state = growth_cycle.get_current_growth_state()
	sprite_2d.frame = start_frame - 1 + growth_state
	if growth_state == DataTypes.GrowthStates.Maturity:
		flowering_particles.emitting = true
	
func on_hurt(hit_damage: int) -> void:
	if !growth_cycle.is_watered:
		watering_particles.emitting = true
		await get_tree().create_timer(5.0).timeout
		watering_particles.emitting = false
		growth_cycle.is_watered = true
		#ToDo if is watered then adjust shade of crop

func on_crop_maturity() -> void:
	flowering_particles.emitting = true

func on_crop_harvesting() -> void:
	var wheat = wheat_harvest_scene.instantiate() as Node2D
	wheat.global_position = global_position
	get_parent().add_child(wheat)
	queue_free()
