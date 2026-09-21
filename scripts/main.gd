extends Node2D
 
var level: int = 1
var current_level_root: Node = null
var last_transition: String = "forward"
var first_load: bool = true
var level2_played: bool = false
 
const DIALOGUE_SCENE = preload("res://dialouges/dialouge.tscn")
const INTRO_JSON = "res://dialouges/player_monologue_level1.json"
const LEVEL2_JSON = "res://dialouges/player_monologue_level2.json"
 
 
func _ready() -> void:
	level = SaveManager.start_level
	current_level_root = get_node("LevelRoot")
	_load_level(level, "forward")
	
func _load_level(level_number: int, transition_type: String) -> void:
	var is_initial_load = first_load
	first_load = false
	
	if current_level_root:
		current_level_root.queue_free()
		
	var level_path = "res://scenes/levels/level_%s.tscn" % level_number
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "LevelRoot"
	SaveManager.save_level(level_number)
	
	var player = current_level_root.get_node_or_null("Player")
	if player:
		var spawn_name = "SpawnFromLeft" if transition_type == "forward" else "SpawnFromRight"
		var spawn_node = current_level_root.get_node_or_null(spawn_name)
		if spawn_node:
			player.global_position = spawn_node.global_position
			var camera = player.get_node_or_null("Camera2D")
			if camera:
				camera.reset_smoothing()
 
	_setup_level(current_level_root)
	
	# Monologues
	if level_number == 1 and SaveManager.play_intro:
		SaveManager.play_intro = true
		_play_monologue.call_deferred(INTRO_JSON)
	elif level_number == 2 and transition_type == "forward" and not is_initial_load and not level2_played:
		level2_played = true
		_play_monologue.call_deferred(LEVEL2_JSON)
 
func _play_monologue(json_path: String) -> void:
	var dialogue = DIALOGUE_SCENE.instantiate()
	dialogue.d_file = json_path
	add_child(dialogue)
	dialogue.dialouge_finished.connect(dialogue.queue_free)
	dialogue.start()
 
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
 
