class_name CropsCursor
extends Node2D

@export var tilled_soil_tilemap_layer: TileMapLayer

@onready var player: Player = get_tree().get_first_node_in_group("player")

var wheat_plant_scene = preload("res://Scenes/Objects/Crops/Wheat.tscn")

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance: float

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("undo_till"):
		print("undoing till")
		if ToolManager.selected_tool == DataTypes.Tools.TillGround || ToolManager.selected_tool == DataTypes.Tools.ChopWood:
			get_cell_under_mouse()
			remove_plant()
	elif event.is_action_pressed("action"):
		if ToolManager.selected_tool == DataTypes.Tools.PlantCrops:
			print("trying to plant crops")
			get_cell_under_mouse()
			add_plant()

func get_cell_under_mouse() -> void:
	mouse_position = tilled_soil_tilemap_layer.get_local_mouse_position()
	cell_position = tilled_soil_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = tilled_soil_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = tilled_soil_tilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_to(get_global_mouse_position())
	
	print("mouse position: ", mouse_position, " cell position: ", cell_position, " cell source id: ", cell_source_id)
	print("distance: ", distance)

func add_plant() -> void:
	if distance < 20.0 and cell_source_id == 6:
		#Update to switch based on crop type equiped
		var plant = wheat_plant_scene.instantiate() as Node2D
		print(local_cell_position)
		print(plant.global_position)
		plant.global_position = tilled_soil_tilemap_layer.to_global(local_cell_position)
		print(plant.global_position)
		get_parent().find_child("Crops").add_child(plant)

func remove_plant() -> void:
	if distance < 20.0:
		var crops = get_parent().find_child("Crops").get_children()
		
		for node: Node2D in crops:
			if node.global_position == local_cell_position:
				node.queue_free()
