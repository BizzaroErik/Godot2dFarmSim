class_name TestSceneSaveDataManagerComponent
extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("load_test_scene")


func load_test_scene():
	SaveGameManager.load_game()
