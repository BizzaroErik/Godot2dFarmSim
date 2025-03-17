extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("enable_tool_buttons")
	

func enable_tool_buttons() -> void:
	ToolManager.enable_tool_button(DataTypes.Tools.ChopWood)
	ToolManager.enable_tool_button(DataTypes.Tools.WaterCrops)
	ToolManager.enable_tool_button(DataTypes.Tools.TillGround)
	ToolManager.enable_tool_button(DataTypes.Tools.PlantCrops)
	ToolManager.enable_tool_button(DataTypes.Tools.MineRock)
