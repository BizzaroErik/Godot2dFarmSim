extends StaticBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var door_collision: CollisionShape2D = $CollisionShape2D
@onready var interactable: Interactable = $Interactable


func _ready() -> void:
	interactable.interactable_activated.connect(on_interactable_activated)
	interactable.interactable_deactivated.connect(on_interactable_deactivated)
	

func on_interactable_activated() -> void:
	#possible to disable the collision manually but will keep as a layer change for future character ai pathing
	#door_collision.set_deferred("disabled", true)
	collision_layer = 2
	sprite.play("open_door")

func on_interactable_deactivated() -> void:
	#door_collision.set_deferred("disabled", false)
	collision_layer = 1
	sprite.play("close_door")
