extends Control

signal dialouge_finished

@export_file("*.json") var d_file

var dialouge = []
var current_dialogue_id = 0
var d_active = false

func _ready():
	$NinePatchRect.visible = false
	
func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true
	dialouge = load_dialouge()
	current_dialogue_id = -1
	next_script()

func load_dialouge():
	var file = FileAccess.open("res://dialouges/worker_dialouge.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func _input(event):
	if !d_active:
		return
	if event.is_action_pressed("ui_accept"):
		next_script()

func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialouge):
		d_active = false
		$NinePatchRect.visible = false
		emit_signal("dialouge_finished")
		return
	
	$NinePatchRect/Name.text = dialouge[current_dialogue_id]['name']
	$NinePatchRect/Text.text = dialouge[current_dialogue_id]['text']
