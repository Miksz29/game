extends Area2D

@export var quest_resource: Quest
var triggered = false

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player") and not triggered:
		triggered = true
		$Dialouge.start()

func _on_dialouge_dialouge_finished() -> void:
	if quest_resource != null:
		QuestManager.complete_quest(quest_resource.id)

func _quest_is_completed() -> bool:
	if quest_resource == null:
		return false
	if QuestManager.activeQuests.has(quest_resource.id):
		return QuestManager.activeQuests[quest_resource.id].is_completed
	return false
