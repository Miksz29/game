extends Area2D

@onready var quest_to_complete: Quest = preload("res://quest/level8/level8_1.tres")
var triggered = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player") and not triggered:
		triggered = true
		$Dialouge.start()