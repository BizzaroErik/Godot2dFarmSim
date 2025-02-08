extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering: Button = $MarginContainer/HBoxContainer/ToolWatering
@onready var tool_corn: Button = $MarginContainer/HBoxContainer/ToolCorn


func _on_tool_axe_pressed() -> void:
	ToolManager.set_tool(DataTypes.Tools.ChopWood)


func _on_tool_tilling_pressed() -> void:
	ToolManager.set_tool(DataTypes.Tools.TillGround)


func _on_tool_watering_pressed() -> void:
	ToolManager.set_tool(DataTypes.Tools.WaterCrops)


func _on_tool_corn_pressed() -> void:
	ToolManager.set_tool(DataTypes.Tools.PlantCrops)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("unequip"):
		ToolManager.set_tool(DataTypes.Tools.None)
		tool_axe.release_focus()
		tool_tilling.release_focus()
		tool_watering.release_focus()

func _on_tool_tomato_pressed() -> void:
	pass # Replace with function body.
