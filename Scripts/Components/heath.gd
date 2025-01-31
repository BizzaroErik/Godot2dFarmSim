class_name Health
extends Node2D

@export var start_health = 1
@export var current_health = 1

signal dead

func apply_damage(damage: int) -> void:
	current_health = clamp(current_health - damage, 0, start_health)
	if current_health == 0:
		dead.emit()
