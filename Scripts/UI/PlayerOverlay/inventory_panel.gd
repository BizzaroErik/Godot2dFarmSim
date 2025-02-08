extends PanelContainer

#ToDo: Make dynamic panel container that expands if player has item
#ToDo: Make dynamic inventory naming of objects based on collectable picked up not on static naming
@onready var log_label: Label = $MarginContainer/VBoxContainer/Logs/LogLabel
@onready var stone_label: Label = $MarginContainer/VBoxContainer/Stone/StoneLabel
@onready var wheat_label: Label = $MarginContainer/VBoxContainer/Wheat/WheatLabel
@onready var egg_label: Label = $MarginContainer/VBoxContainer/Egg/EggLabel

func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)

func on_inventory_changed() -> void:
	var inventory: Dictionary = InventoryManager.inventory
	
	if inventory.has("log"):
		log_label.text = str(inventory["log"])
	if inventory.has("stone"):
		stone_label.text = str(inventory["stone"])
	if inventory.has("wheat"):
		wheat_label.text = str(inventory["wheat"])
	if inventory.has("egg"):
		egg_label.text = str(inventory["egg"])
