extends StaticBody2D

signal detruite

func detruire() -> void:
	detruite.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("rotation")
	await $AnimationPlayer.animation_finished
	queue_free()
