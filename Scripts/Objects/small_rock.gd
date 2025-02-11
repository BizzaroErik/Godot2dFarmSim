extends Sprite2D


@onready var hurtable: Hurtable = $Hurtable
@onready var health: Health = $Health

var rock_scene = preload("res://Scenes/Objects/Collectables/Rock.tscn")

func _ready() -> void:
	hurtable.hurt.connect(on_hurt)
	health.dead.connect(on_max_damage_reached)

func on_hurt(hit_damage: int) -> void:
	health.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensity", 0.3)
	await get_tree().create_timer(0.5).timeout
	material.set_shader_parameter("shake_intensity", 0.0)

func on_max_damage_reached() -> void:
	call_deferred("add_rock")
	queue_free()

func add_rock() -> void:
	var rock = rock_scene.instantiate() as Node2D
	rock.global_position = global_position
	get_parent().add_child(rock)
