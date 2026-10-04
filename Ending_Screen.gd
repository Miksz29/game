extends Control

const BACKSTORY_JSON = "res://dialouges/Ending_Screen.json"  # ← changed path

@onready var label: Label = $Label
@onready var prompt_label: Label = $PromptLabel

var lines: Array = []
var current_index: int = 0
var char_delay: float = 0.04
var is_typing: bool = false

func _ready() -> void:
	QuestUi.hide()
	prompt_label.visible = false
	lines = _load_lines()
	current_index = 0
	await _type_line(lines[current_index]['text'])
	prompt_label.visible = true

func _type_line(full_text: String) -> void:
	is_typing = true
	label.text = full_text
	label.visible_characters = 0
	for i in range(full_text.length() + 1):
		label.visible_characters = i
		await get_tree().create_timer(char_delay).timeout
	is_typing = false

func _load_lines() -> Array:
	var file = FileAccess.open(BACKSTORY_JSON, FileAccess.READ)
	return JSON.parse_string(file.get_as_text())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if is_typing:
			label.visible_characters = -1
			is_typing = false
			return

		current_index += 1
		if current_index >= lines.size():
			get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")   # ← changed destination
		else:
			prompt_label.visible = false
			await _type_line(lines[current_index]['text'])
			prompt_label.visible = true
