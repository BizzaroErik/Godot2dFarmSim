class_name GrowthCycle
extends Node


@export var current_growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Germination
@export_range(5, 365) var days_until_harvest: int = 6

signal crop_maturity
signal crop_harvesting

var is_watered: bool
var starting_day: int = 0
var current_day: int

func _ready() -> void:
	DayNightManager.time_tick_day.connect(on_time_tick_day)
	print(get_current_growth_state())

func on_time_tick_day(day: int) -> void:
	if starting_day == 0:
		starting_day = day
	if is_watered:
		growth_states(starting_day, day)
		harvest_state(starting_day, day)
	#is_watered = false

func growth_states(starting_day: int, current_day: int) -> void:
	#Check if crop has reached maturity and return as nothing to adjust
	if current_growth_state == DataTypes.GrowthStates.Maturity:
		return
	
	var num_states = 4
	
	#ToDo: Check double modelo call
	#Find the current index of state to match with the animation index
	var growth_days_passed = (current_day - starting_day) % num_states
	var state_index = growth_days_passed % num_states + 1
	current_growth_state = state_index
	#ToDo: Adjust growth pattern on a per crop basis
	var name = DataTypes.GrowthStates.keys()[current_growth_state]
	print("Current growth state: ", name, "State Index: ", state_index)
	if current_growth_state == DataTypes.GrowthStates.Maturity:
		crop_maturity.emit()


func harvest_state(starting_day: int, current_day: int) -> void:
	if current_growth_state == DataTypes.GrowthStates.Harvesting:
		return
	
	var days_passed = (current_day - starting_day) % days_until_harvest
	
	if days_passed == days_until_harvest - 1:
		current_growth_state = DataTypes.GrowthStates.Harvesting
		crop_harvesting.emit()

func get_current_growth_state() -> DataTypes.GrowthStates:
	return current_growth_state
