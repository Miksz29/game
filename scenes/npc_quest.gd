extends Control

signal quest_menu_closed

var quest1_active = false
var quest1_completed = false
var stick = 0


func _ready() -> void:
	$quest1_ui.visible = false
func process(delta: float) -> void:
	if quest1_active:
		if stick == 1:
			print("Alright now you can head to your first patient")
			quest1_active = false
			quest1_completed = true

func quest1_chat():
	$quest1_ui.visible = true

func next_quest():
	if !quest1_completed:
		quest1_chat()
	else:
		$no_quest.visible = true
		await get_tree().create_timer(3).timeout
		$no_quest.visible = false

func _on_button_pressed() -> void:
	$quest1_ui.visible = false
	quest1_active = true
	stick = 0
	emit_signal("quest_menu_closed")
