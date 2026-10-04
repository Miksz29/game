extends CanvasLayer

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
