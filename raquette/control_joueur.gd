extends CharacterBody2D

@export var vitesse = 500

var position_y_fixe : float

func _ready() -> void:
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y - get_viewport_rect().size.y / 6
	position_y_fixe = position.y

func _physics_process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("p1_right"):
		direction = 1
	elif Input.is_action_pressed("p1_left"):
		direction = -1
	
	velocity.x = direction * vitesse
	velocity.y = 0
	move_and_slide()
	
	position.y = position_y_fixe  # on force le Y à rester fixe, quoi qu'il arrive
