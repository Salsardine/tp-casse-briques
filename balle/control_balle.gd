extends RigidBody2D

@export var vitesse_initiale = 350

func _ready() -> void:
	position = get_viewport_rect().size / 2
	linear_velocity = Vector2(0, vitesse_initiale)
	
	contact_monitor = true
	max_contacts_reported = 4
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	if linear_velocity.length() > 0:
		linear_velocity = linear_velocity.normalized() * vitesse_initiale

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("raquette"):
		$AudioRaquette.play()
	
	elif body.is_in_group("bordure"):
		$AudioBordure.play()
	
	elif body.is_in_group("brique"):
		$AudioBrique.play()
