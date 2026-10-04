extends Area2D

var triggered = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player") and not triggered:
		triggered = true
		$Dialouge.start()
