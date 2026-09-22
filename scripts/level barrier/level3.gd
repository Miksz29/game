extends CollisionShape2D

@onready var quest_level: Quest = preload("res://quest/level2/level2_1.tres")

func _ready() -> void:
	QuestManager.quest_completed.connect(_on_quest_completed)

func _on_quest_completed(quest: Quest):
	if (quest.id == quest_level.id):
		queue_free()
	
