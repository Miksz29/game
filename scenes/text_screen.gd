extends Control

@onready var prompt_label: Label = $PromptLabel

func _ready() -> void:
	prompt_label.visible = false
	await get_tree().create_timer(1.0).timeout
	prompt_label.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().create_timer(1.0).timeout.connect(Bgm.play)
		get_tree().change_scene_to_file("res://scenes/main.tscn")
