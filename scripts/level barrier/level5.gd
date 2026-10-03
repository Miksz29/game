extends CollisionShape2D

@onready var quest_level: Quest = preload("res://quest/level3/level3_1.tres")

func _ready() -> void:
	QuestManager.quest_completed.connect(_on_quest_completed)

func _on_quest_completed(quest: Quest):
	if (quest_level.is_completed):
		queue_free()
	
