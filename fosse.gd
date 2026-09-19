extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("balle"):
		ScoreTracker.message_fin = "Vous avez perdu :(\nScore de la partie : %d" % ScoreTracker.score
		ScoreTracker.victoire = false
		get_tree().change_scene_to_file("res://restart/fin_de_partie.tscn")
