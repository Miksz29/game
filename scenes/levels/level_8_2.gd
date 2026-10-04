extends Area2D

@onready var quest_to_complete: Quest = preload("res://quest/level8/level8_1.tres")
@onready var first_indicator = $"../FirstIndicator"
@onready var second_indicator = $"../SecondIndicator"
var triggered = false

func _ready() -> void:
	second_indicator.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player") and not triggered:
		triggered = true
		$Dialouge.start()

func _on_dialouge_dialouge_finished() -> void:
	QuestManager.add_quest(quest_to_complete)
	first_indicator.hide()
	second_indicator.show()
	