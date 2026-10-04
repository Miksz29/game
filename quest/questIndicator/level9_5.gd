extends Area2D

@onready var quest_to_complete: Quest = preload("res://quest/level9/level9_1.tres")
@onready var quest_to_complete2: Quest = preload("res://quest/level9/level9_2.tres")
@onready var fifth_indicator = $"../FifthIndicator"
@onready var sixth_indicator = $"../SixthIndicator"
@onready var label = $Label
var player_in_chat_zone = false
var is_chatting = false

func _ready() -> void:
	sixth_indicator.hide()
	label.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = true
		if !quest_to_complete.is_completed:
			label.show()

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = false
		label.hide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("chat") and player_in_chat_zone and !is_chatting and !quest_to_complete.is_completed:
		$Dialouge.start()
		is_chatting = true

func _on_dialouge_dialouge_finished() -> void:
	QuestManager.complete_quest(quest_to_complete.id)
	QuestManager.add_quest(quest_to_complete2)
	fifth_indicator.hide()
	sixth_indicator.show()
