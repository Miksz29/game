extends CanvasLayer

@onready var label_1 = $PanelContainer/HBoxContainer/Label_1
@onready var label_2 = $PanelContainer/HBoxContainer/Label_2

func _ready():
	QuestManager.quest_added.connect(_on_quest_added)
	QuestManager.quest_completed.connect(_on_quest_completed)

func _on_quest_added(quest: Quest):
	if quest.is_completed:
		return
	if (!label_1.get_meta("isAvailable")):
		label_1.set_meta("questId",quest.id)
		label_1.set_meta("isAvailable",true)
		label_1.text = quest.description
	elif(!label_2.get_meta("isAvailable")):
		label_2.set_meta("questId",quest.id)
		label_2.set_meta("isAvailable",true)
		label_2.text = quest.description
	
func _on_quest_completed(quest: Quest):
	if (label_1.get_meta("questId")==quest.id):
		label_1.add_theme_color_override("font_color", Color("#007600"))
		await get_tree().create_timer(1.5).timeout
		label_1.text = ""
		label_1.set_meta("isAvailable",false)
		label_1.add_theme_color_override("font_color", Color.BLACK)
	elif (label_2.get_meta("questId")==quest.id):
		label_2.add_theme_color_override("font_color", Color("#007600"))
		await get_tree().create_timer(1.5).timeout
		label_2.text = ""
		label_2.set_meta("isAvailable",false)
		label_2.add_theme_color_override("font_color", Color.BLACK)
		
		
		
