extends StaticBody2D

signal detruite

func _ready() -> void:
	$Area2D.body_entered.connect(_on_area_body_entered)

func _on_area_body_entered(body: Node) -> void:
	if body.is_in_group("balle"):
		detruite.emit()
		queue_free()
