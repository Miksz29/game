extends Sprite2D

@export var bob_height: float = 10.0
@export var bob_speed: float = 3.0
@onready var quest_level: Quest = preload("res://quest/level2/level2_1.tres")

var start_y: float
var time_passed: float = 0.0

func _ready() -> void:
	start_y = position.y
	QuestManager.quest_completed.connect(_on_quest_completed)

func _process(delta: float) -> void:
	time_passed += delta
	position.y = start_y + sin(time_passed * bob_speed) * bob_height

func _on_quest_completed(quest: Quest):
	if (quest_level.is_completed):
		hide()