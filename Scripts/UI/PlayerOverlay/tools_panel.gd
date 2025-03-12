extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering: Button = $MarginContainer/HBoxContainer/ToolWatering
@onready var tool_corn: Button = $MarginContainer/HBoxContainer/ToolCorn

func _ready() -> void:
	
	ToolManager.enable_tool.connect(on_enable_tool_button)
	tool_axe.disabled = true
	tool_axe.focus_mode = Control.FOCUS_NONE
	tool_tilling.disabled = true
	tool_tilling.focus_mode = Control.FOCUS_NONE
	tool_watering.disabled = true
	tool_watering.focus_mode = Control.FOCUS_NONE
	tool_corn.disabled = true
	tool_corn.focus_mode = Control.FOCUS_NONE

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

func on_enable_tool_button(tool: DataTypes.Tools) -> void:
	if tool == DataTypes.Tools.ChopWood:
		tool_axe.disabled = false
		tool_axe.focus_mode = Control.FOCUS_ALL
	elif tool == DataTypes.Tools.TillGround:
		tool_tilling.disabled = false
		tool_tilling.focus_mode = Control.FOCUS_ALL
	elif tool == DataTypes.Tools.WaterCrops:
		tool_watering.disabled = false
		tool_watering.focus_mode = Control.FOCUS_ALL
	elif tool == DataTypes.Tools.PlantCrops:
		tool_corn.disabled = false
		tool_corn.focus_mode = Control.FOCUS_ALL
