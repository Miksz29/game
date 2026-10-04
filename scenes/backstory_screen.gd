extends Control

const BACKSTORY_JSON = "res://dialouges/level9_backstory.json"

@onready var label: Label = $Label
@onready var prompt_label: Label = $PromptLabel

var lines: Array = []
var current_index: int = 0

func _ready() -> void:
	QuestUi.hide()
	prompt_label.visible = false
	lines = _load_lines()
	current_index = 0
	label.text = lines[current_index]['text']
	await get_tree().create_timer(1.0).timeout
	prompt_label.visible = true

func _load_lines() -> Array:
	var file = FileAccess.open(BACKSTORY_JSON, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		current_index += 1
		if current_index >= lines.size():
			SaveManager.start_level = 10
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		else:
			label.text = lines[current_index]['text']
