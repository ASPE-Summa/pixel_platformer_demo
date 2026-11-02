extends CharacterBody2D

@onready var _animation_player : AnimatedSprite2D = %AnimatedSprite2D

#J02
@export_range(-1000,0, 50, "Hoe hoog het karakter springt -1000 is het hoogst") var jump_velocity: float = -400.0
#W02
@export_range(0,500, 50, "Hoe snel het karakter loopt") var walk_speed :float = 100.0

func _ready(): 
	_animation_player.play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
	# Vervolgens kun je met Input.is_action_pressed("Jump") zien of iemand de spring knop heeft ingevoerd.
	# Maak een if statement wat die input combineert met is_on_floor() zodat de code uitgevoerd wordt
	# waneer op de spring knop gedrukt wordt EN het personage op de grond staat.
	# In dat geval mag de volgende code uitgevoerd worden:
	## velocity.y = JUMP_VELOCITY
	## animation_player.play("Jump")
	if Input.is_action_pressed("Jump") and is_on_floor():
		if has_method("jump"):
			jump()
	
	# Tot slot willen we dat als het personage stilstaat op de grond, de idle animation afspeelt.
	# Gebruik hiervoor is_on_floor() en de velocity.y
	# De animatie afspelen werkt soortgelijk aan hoe je net Jump hebt afgespeeld.
	if velocity.length() == 0 and is_on_floor():
		_animation_player.play("Idle")
		
	var input_direction := Vector2(Input.get_axis("move_left", "move_right"), 0)
	if input_direction.length() > 0:
		walk(input_direction)
	else:
		velocity.x = lerpf(velocity.x, 0.0, 1)
	
		# met is_on_floor() kun je controleren of een personage op de grond staat
	# als hij NIET op de grond staat, voer dan de code op de volgende regel uit:
	## velocity.y += get_gravity().y * delta
	# Die code zorgt ervoor dat het personage op de Y as naar beneden beweegt
	if not is_on_floor():
		fall(delta)
	# Dit is de allerlaatste regel van _process en zorgt dat de velocity ook echt gebruikt wordt om het
	# personage te laten bewegen.	
	move_and_slide()

#F01
## Hier zorgen we dat de speler omlaag valt als hij in de lucht is.
## De delta zorgt ervoor dat dit geleidelijk gebeurt
func fall(delta : float) -> void:
	#F02
	velocity.y += get_gravity().y * delta

#J01
## De jump functie gebeurt elke keer als iemand op de jump knop klikt
func jump()->void:
	#J03
	velocity.y = jump_velocity
	
	#J04
	_animation_player.play("Jump")

#W01
## Als de speler links of rechts indrukt moet het karakter aan lopen.
func walk(input_direction: Vector2)->void:
	#W03
	velocity.x = input_direction.x * walk_speed
	
	#W04
	_animation_player.play("Walk")
	
	#W05
	if input_direction.x < 0:
		_animation_player.flip_h = true
	else:
		_animation_player.flip_h = false
	
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if(body is CharacterBody2D and body != self):
		get_tree().call_deferred("reload_current_scene")


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	get_tree().call_deferred("reload_current_scene")
