extends CanvasLayer

@onready var quest_list = $PanelContainer/VBoxContainer

func _ready():
	QuestManager.quest_added.connect(_on_quest_added)
	QuestManager.quest_completed.connect(_on_quest_completed)

func _on_quest_added(quest: Quest):
	if quest.is_completed:
		return
	var label := Label.new()
	label.name = quest.id
	label.text = quest.description
	quest_list.add_child(label)

func _on_quest_completed(quest: Quest):
	var label = quest_list.get_node_or_null(quest.id)
	if label != null:
		label.modulate = Color.GREEN
		label.text = quest.description + " - DONE!"
		await get_tree().create_timer(3.0).timeout
		label.queue_free()