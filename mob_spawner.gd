extends Node2D

@export var enemy_scene : PackedScene
@onready var enemy_spawn_point : Marker2D = %EnemySpawnPoint


func _on_enemy_spawn_timer_timeout() -> void:
	var mob : CharacterBody2D = enemy_scene.instantiate()
	mob.transform = enemy_spawn_point.transform
	add_child(mob)
