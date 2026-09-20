extends CharacterBody2D

signal joueur_rejoint(id: String)

@export var vitesse = 400

@export var joueur_id : String = "p1"

@export var actif_au_demarrage : bool = true

@export var largeur_raquette : float = 64.0

@export var skin_p1 : Texture2D = preload("res://raquette/skin_raquette_a.tres")
@export var skin_p2 : Texture2D = preload("res://raquette/skin_raquette_b.tres")

var position_y_fixe : float
var actif : bool = true
var sprite : Sprite2D

func _ready() -> void:
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y - get_viewport_rect().size.y / 6
	position_y_fixe = position.y
	var skin_choisi = skin_p1 if joueur_id == "p1" else skin_p2
	if $Sprite2D and skin_choisi:
		$Sprite2D.texture = skin_choisi
		
	actif = actif_au_demarrage
	if not actif:
		visible = false
		set_physics_process(false)
		$CollisionShape2D.set_deferred("disabled", true)

func _unhandled_input(event: InputEvent) -> void:
	if actif:
		return
	if event.is_action_pressed(joueur_id + "_right") or event.is_action_pressed(joueur_id + "_left"):
		activer()

func activer() -> void:
	actif = true
	visible = true
	set_physics_process(true)
	$CollisionShape2D.set_deferred("disabled", false)
	joueur_rejoint.emit(joueur_id)

func _physics_process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed(joueur_id + "_right"):
		direction = 1
	elif Input.is_action_pressed(joueur_id + "_left"):
		direction = -1

	velocity.x = direction * vitesse
	velocity.y = 0
	move_and_slide()
	position.y = position_y_fixe
	_empecher_chevauchement()

	if direction != 0:
		if not $AudioDeplacement.playing:
			$AudioDeplacement.play()
	else:
		$AudioDeplacement.stop()

	$ParticulesGauche.emitting = (direction == 1)
	$ParticulesDroite.emitting = (direction == -1)

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("bordure"):
			if not $AudioMurRaquette.playing:
				$AudioMurRaquette.play()
		elif collider.is_in_group("balle"):
			$AnimationRaquette.play("raquette")

func _empecher_chevauchement() -> void:
	var separation_min = largeur_raquette
	for autre in get_tree().get_nodes_in_group("raquette"):
		if autre == self or not ("actif" in autre) or not autre.actif:
			continue
		var largeur_autre = autre.largeur_raquette if "largeur_raquette" in autre else largeur_raquette
		separation_min = (largeur_raquette + largeur_autre) / 2.0
		var delta_x = position.x - autre.position.x
		if abs(delta_x) < separation_min:
			if delta_x >= 0:
				position.x = autre.position.x + separation_min
			else:
				position.x = autre.position.x - separation_min
