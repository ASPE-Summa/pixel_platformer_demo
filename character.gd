extends CharacterBody2D

@onready var animation_player : AnimatedSprite2D = %AnimatedSprite2D

const JUMP_VELOCITY := -400.0

func _ready(): 
	animation_player.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# met is_on_floor() kun je controleren of een personage op de grond staat
	# als hij NIET op de grond staat, voer dan de code op de volgende regel uit:
	## velocity.y += get_gravity().y * delta
	# Die code zorgt ervoor dat het personage op de Y as naar beneden beweegt
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
		
	# Vervolgens kun je met Input.is_action_pressed("Jump") zien of iemand de spring knop heeft ingevoerd.
	# Maak een if statement wat die input combineert met is_on_floor() zodat de code uitgevoerd wordt
	# waneer op de spring knop gedrukt wordt EN het personage op de grond staat.
	# In dat geval mag de volgende code uitgevoerd worden:
	## velocity.y = JUMP_VELOCITY
	## animation_player.play("Jump")
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("Jump")
	
	# Tot slot willen we dat als het personage stilstaat op de grond, de idle animation afspeelt.
	# Gebruik hiervoor is_on_floor() en de velocity.y
	# De animatie afspelen werkt soortgelijk aan hoe je net Jump hebt afgespeeld.
	if velocity.y == 0 and is_on_floor():
		animation_player.play("Idle")
	
	# Dit is de allerlaatste regel van _process en zorgt dat de velocity ook echt gebruikt wordt om het
	# personage te laten bewegen.	
	move_and_slide()


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if(body is CharacterBody2D and body != self):
		get_tree().call_deferred("reload_current_scene")
