extends Area2D

@onready var quest_to_complete: Quest = preload("res://quest/level2/level2_1.tres")
@onready var quest_to_complete2: Quest = preload("res://quest/level2/level2_2.tres")
var is_player_inside: bool = false

@onready var prompt_label = $Label

func _ready() -> void:
	prompt_label.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_inside = true
		if !quest_to_complete.is_completed:
			prompt_label.show()
		
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_inside = false
		prompt_label.hide()


func _unhandled_input(event: InputEvent) -> void:
	# Check if the player is inside AND they just pressed the interact key
	if is_player_inside and event.is_action_pressed("quest") and !quest_to_complete.is_completed:
		QuestManager.complete_quest(quest_to_complete.id)
		QuestManager.add_quest(quest_to_complete2)
