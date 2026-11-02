extends Area2D

@onready var _animation_player : AnimatedSprite2D = %AnimatedSprite2D
@onready var _particles : CPUParticles2D = %celebration_particles
@export var gameover_label : Label

func _on_area_entered(_area: Area2D) -> void:
	_animation_player.play("open")
	_particles.emitting = true
	gameover_label.show()
	get_tree().paused = true
