extends StaticBody2D

signal detruite(points)
@export var valeur : int = 100

func detruire() -> void:
	detruite.emit(valeur)
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("rotation")
	await $AnimationPlayer.animation_finished
	queue_free()
