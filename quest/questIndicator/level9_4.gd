extends Area2D
@onready var quest_to_complete: Quest = preload("res://quest/level9/level9_1.tres")
@onready var fourth_indicator = $"../FourthIndicator"
@onready var fifth_indicator = $"../FifthIndicator"
var triggered = false

func _ready() -> void:
	fifth_indicator.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player") and not triggered:
		triggered = true
		$Dialouge.start()

func _on_dialouge_dialouge_finished() -> void:
	fourth_indicator.hide()
	fifth_indicator.show()
	QuestManager.add_quest(quest_to_complete)
	
