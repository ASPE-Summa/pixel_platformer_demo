extends CharacterBody2D


const SPEED = 5500.0



func _physics_process(delta: float) -> void:
	velocity.x = SPEED * delta * Vector2.LEFT.x
	velocity.y += get_gravity().y * delta
	
	if is_on_floor() == false:
		rotation_degrees -= 2
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
