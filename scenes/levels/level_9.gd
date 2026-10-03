extends Area2D

@export var quest_resource: Quest
var player_in_chat_zone = false
var is_chatting = false



func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = true


func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("chat") and player_in_chat_zone and !is_chatting and not _quest_is_completed():
		$Dialouge.start()
		is_chatting = true

func _on_dialouge_dialouge_finished() -> void:
	if quest_resource != null:
		QuestManager.complete_quest(quest_resource.id)
	var main = get_tree().get_root().get_node("Main")  # adjust node name/path if different
	main.level = 10
	main.call_deferred("_load_level", 10, "forward")

func _quest_is_completed() -> bool:
	if quest_resource == null:
		return false
	if QuestManager.activeQuests.has(quest_resource.id):
		return QuestManager.activeQuests[quest_resource.id].is_completed
	return false
