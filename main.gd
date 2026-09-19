extends Node2D

@export var scene_brique : PackedScene
@export var nb_colonnes = 1
@export var nb_lignes = 2
@export var espacement_x = 20
@export var espacement_y = 20
@export var marge_haut = 50

var briques_restantes = 0

func _ready() -> void:
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

func _on_brique_detruite() -> void:
	briques_restantes -= 1
	if briques_restantes <= 0:
		GameState.message_fin = "Gagné !"
		GameState.victoire = true
		get_tree().change_scene_to_file("res://restart/fin_de_partie.tscn")
