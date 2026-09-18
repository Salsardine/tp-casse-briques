extends Control

func _ready() -> void:
	$Label.text = GameState.message_fin
	$Button.pressed.connect(_on_button_pressed)
	
	if GameState.victoire:
		$AudioVictoire.play()
	else:
		$AudioDefaite.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
