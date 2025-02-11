class_name GrowthCycle
extends Node


@export var current_growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Seed
@export_range(5, 365) var days_until_harvest: int = 7

signal crop_maturity
signal crop_harvesting

var is_watered: bool
var starting_day: int
var current_day: int

func _ready() -> void:
	DayNightManager.time_tick_day.connect(on_time_tick_day)

func on_time_tick_day(day: int) -> void:
	if is_watered:
		if starting_day == 0:
			starting_day = day
		growth_states(starting_day, days_until_harvest)
		harvest_state(starting_day, days_until_harvest)

func growth_states(starting_day: int, current_day: int) -> void:
	#Check if crop has reached maturity and return as nothing to adjust
	if current_growth_state == DataTypes.GrowthStates.Maturity:
		return
	
	var num_states = 5
	
	#ToDo: Check double modelo call
	#Find the current index of state to match with the animation index
	var growth_days_passed = (current_day - starting_day) % num_states
	var state_index = growth_days_passed % num_states + 1
	
	current_growth_state = state_index
	print("growth states")
	#ToDo: Adjust growth pattern on a per crop basis
	var name = DataTypes.GrowthStates.keys()[40]
	
	if current_growth_state == DataTypes.GrowthStates.Maturity:
		crop_maturity.emit()


func harvest_state(starting_day: int, current_day: int) -> void:
	print("harvest states")
	if current_growth_state == DataTypes.GrowthStates.Harvesting:
		return
	
	var days_passed = (current_day - starting_day) % days_until_harvest
	
	if days_passed == days_until_harvest - 1:
		current_growth_state = DataTypes.GrowthStates.Harvesting
		crop_harvesting.emit()

func get_current_growth_state() -> DataTypes.GrowthStates:
	return current_growth_state
