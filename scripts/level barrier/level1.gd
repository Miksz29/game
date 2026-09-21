extends CollisionShape2D

@onready var quest_level1_1: Quest = preload("res://quest/level1/level1_1.tres")

func _ready() -> void:
	QuestManager.quest_completed.connect(_on_quest_completed)

func _on_quest_completed(quest: Quest):
	if (quest.id == quest_level1_1.id):
		queue_free()
	
