extends Node2D

var level: int = 1
var current_level_root: Node = null
var last_transition: String = "forward"


func _ready() -> void:
	_load_level(level, "forward")
	
func _load_level(level_number: int, transition_type: String) -> void:
	if current_level_root:
		current_level_root.queue_free()
		
	var level_path = "res://scenes/levels/level_%s.tscn" % level_number
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "LevelRoot"
	
	
	var player = current_level_root.get_node("Player")
	if player:
		var spawn_name = "SpawnFromLeft" if transition_type == "forward" else "SpawnFromRight"
		var spawn_node = current_level_root.get_node_or_null(spawn_name)
		if spawn_node:
			player.global_position = spawn_node.global_position

	_setup_level(current_level_root)

func _setup_level(level_root: Node) -> void:
	var exit = level_root.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)
		
	var exit_back = level_root.get_node_or_null("Exit_back")
	if exit_back:
		exit_back.body_entered.connect(_on_exit_back_body_entered)

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level += 1
		last_transition = "forward"
		call_deferred("_load_level", level, last_transition)

func _on_exit_back_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level -= 1
		last_transition = "back"
		call_deferred("_load_level", level, last_transition)
