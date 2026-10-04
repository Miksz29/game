extends Node2D

func _ready() -> void:
	$Area2D5/Dialouge.dialouge_finished.connect(_on_note_dialogue_finished)

func _on_note_dialogue_finished() -> void:
	QuestUi.hide()
	get_tree().change_scene_to_file("res://scenes/backstory_screen.tscn")
