extends Node2D

@export var scene_brique : PackedScene
@export var nb_colonnes = 5
@export var nb_lignes = 5
@export var espacement_x = 20
@export var espacement_y = 20
@export var marge_haut = 50

var briques_restantes = 0
var score = 0

func _ready() -> void:
	score = 0
	$Score.text = "Score : 0"
	$MessageEncourageant.text = ""
	generer_briques()

func generer_briques() -> void:
	var brique_temp = scene_brique.instantiate()
	var taille_brique = brique_temp.get_node("CollisionShape2D").shape.get_rect().size
	brique_temp.queue_free()
	
	var largeur_totale = nb_colonnes * (taille_brique.y + espacement_x) - espacement_x
	var marge_gauche = (get_viewport_rect().size.x - largeur_totale) / 2.0
	
	briques_restantes = 0
	
	for ligne in range(nb_lignes):
		for colonne in range(nb_colonnes):
			var brique = scene_brique.instantiate()
			var x = marge_gauche + colonne * (taille_brique.y + espacement_x) + taille_brique.y / 2.0
			var y = marge_haut + ligne * (taille_brique.x + espacement_y) + taille_brique.x / 2.0
			brique.position = Vector2(x, y)
			brique.detruite.connect(_on_brique_detruite)
			add_child(brique)
			briques_restantes += 1

func _on_brique_detruite(points: int) -> void:
	briques_restantes -= 1
	ScoreTracker.score += points * ScoreTracker.cpt_hotness
	ScoreTracker.cpt_hotness += 1
	$Score.text = "Score : %d" % ScoreTracker.score
	if ScoreTracker.cpt_hotness > 2 and ScoreTracker.cpt_hotness < 5:
		$MessageEncourageant.text = "OUAIS CONTINUE COMME ÇA ! x%d" % ScoreTracker.cpt_hotness
		$AnimationEncouragement.play("encouragement1")
	elif ScoreTracker.cpt_hotness >= 5:
		$MessageEncourageant.text = "Je te crois pas tu triche x%d"  % ScoreTracker.cpt_hotness
		$AnimationEncouragement.play("encouragement1")
	else :
		$MessageEncourageant.text = ""		
		
	$AnimationScore.play("anim_score")
	
	if briques_restantes <= 0:
		ScoreTracker.message_fin = "Gagné !\nScore de la partie : %d" % ScoreTracker.score
		ScoreTracker.victoire = true
		get_tree().change_scene_to_file("res://restart/fin_de_partie.tscn")
