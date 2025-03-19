extends Node

var balloon_scene = preload("res://Dialogue/game_dialogue_balloon.tscn")

@onready var interactable: Interactable = $Interactable
@onready var interactable_label: Control = $InteractableLabel

var in_range: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interactable_activated.connect(on_interactable_activated)
	interactable.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label.hide()
	
	GameDialogueManager.give_crop_seeds.connect(on_give_crop_seeds)

func on_interactable_activated() -> void:
	interactable_label.show()
	in_range = true
func on_interactable_deactivated() -> void:
	interactable_label.hide()
	in_range = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("show_dialogue") and in_range:
		var balloon: BaseGameDialogueBalloon = balloon_scene.instantiate()
		get_tree().current_scene.add_child(balloon)
		balloon.start(load("res://Dialogue/Convos/guide.dialogue"), "start")
	
func on_give_crop_seeds() -> void:
	ToolManager.enable_tool_button(DataTypes.Tools.ChopWood)
	ToolManager.enable_tool_button(DataTypes.Tools.TillGround)
	ToolManager.enable_tool_button(DataTypes.Tools.WaterCrops)
	ToolManager.enable_tool_button(DataTypes.Tools.PlantCrops)
