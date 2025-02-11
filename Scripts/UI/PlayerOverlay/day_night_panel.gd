extends Control


@onready var day_label: Label = $DayPanel/MarginContainer/Label
@onready var time_label: Label = $TimePanel/MarginContainer/Label

@export var normal_speed: float = 5.0
@export var fast_speed: float = 50.0
@export var fastest_speed: float = 200.0

func _ready() -> void:
	DayNightManager.time_tick.connect(on_time_tick)


func on_time_tick(day: int, hour: int, minute: int) -> void:
	day_label.text = "Day " + str(day)
	time_label.text = "%02d:%02d" % [hour, minute]




func _on_normal_speed_button_pressed() -> void:
	DayNightManager.game_speed = normal_speed




func _on_fast_speed_button_pressed() -> void:
	DayNightManager.game_speed = fast_speed




func _on_fastest_speed_button_pressed() -> void:
	DayNightManager.game_speed = fastest_speed
