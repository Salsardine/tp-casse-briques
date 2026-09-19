extends Control

func _ready() -> void:
	$Label.text = ScoreTracker.message_fin
	$Button.pressed.connect(_on_button_pressed)
	
	if ScoreTracker.victoire:
		$AudioVictoire.play()
	else:
		$AudioDefaite.play()

func _on_button_pressed() -> void:
	ScoreTracker.score = 0
	get_tree().change_scene_to_file("res://main.tscn")
