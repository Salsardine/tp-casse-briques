extends RigidBody2D

@export var vitesse_initiale = 400

func _ready() -> void:
	position = get_viewport_rect().size / 2
	linear_velocity = Vector2(0, vitesse_initiale)

func _physics_process(delta: float) -> void:
	if linear_velocity.length() > 0:
		linear_velocity = linear_velocity.normalized() * vitesse_initiale
