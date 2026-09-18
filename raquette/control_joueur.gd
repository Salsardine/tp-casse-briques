extends CharacterBody2D

@export var vitesse = 500

func _ready() -> void:
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y - get_viewport_rect().size.y / 6

func _physics_process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("p1_right"):
		direction = 1
	elif Input.is_action_pressed("p1_left"):
		direction = -1
	
	velocity.x = direction * vitesse
	move_and_slide()
