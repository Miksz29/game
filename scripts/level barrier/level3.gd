extends CollisionShape2D

@onready var quest_level: Quest = preload("res://quest/level2/level2_1.tres")
@onready var quest_level2: Quest = preload("res://quest/level2/level2_2.tres")
func _ready() -> void:
	QuestManager.quest_completed.connect(_on_quest_completed)

func _on_quest_completed(quest: Quest):
	if (quest_level.is_completed && quest_level2.is_completed):
		queue_free()
	
