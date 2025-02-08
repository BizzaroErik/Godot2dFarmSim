extends Sprite2D

@onready var hurtable: Hurtable = $Hurtable
@onready var health: Health = $Health

var log_scene = preload("res://Scenes/Objects/Collectables/Log.tscn")

func _ready() -> void:
	hurtable.hurt.connect(on_hurt)
	health.dead.connect(on_max_damage_reached)

func on_hurt(hit_damage: int) -> void:
	health.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensity", 0.5)
	await get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensity", 0.0)

func on_max_damage_reached() -> void:
	call_deferred("add_log")
	queue_free()

func add_log() -> void:
	var log = log_scene.instantiate() as Node2D
	log.global_position = global_position
	get_parent().add_child(log)
