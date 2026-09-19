extends CharacterBody2D

signal stick_collected
signal apple_collected

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
var player_in_chat_zone = false
var is_chatting = false

@onready var quest_level1_1: Quest = preload("res://quest/level1/level1_1.tres") 

func _ready() -> void:
	animated_sprite_2d.play("idle_nurse")
	QuestManager.add_quest(quest_level1_1)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("chat") and player_in_chat_zone and !is_chatting and !quest_level1_1.is_completed:
		$Dialouge.start()
		is_chatting = true

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and !is_chatting:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_dialouge_dialouge_finished() -> void:
	is_chatting = false
	QuestManager.complete_quest("level1-1")

func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = true


func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = false


func _on_npc_quest_quest_menu_closed() -> void:
	is_chatting = false
