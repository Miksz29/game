extends Control
signal dialouge_finished
@export_file("*.json") var d_file
var dialouge = []
var current_dialogue_id = 0
var d_active = false

var text_tween: Tween

var waiting_for_release = false
 
func _ready():
	$NinePatchRect.visible = false

	process_mode = Node.PROCESS_MODE_ALWAYS
 
func start():
	if d_active:
		return
	d_active = true
	$NinePatchRect.visible = true

	get_tree().paused = true
	dialouge = load_dialouge()
	current_dialogue_id = -1
	next_script()
	
	if Input.is_action_pressed("ui_accept"):
		waiting_for_release = true
 
func load_dialouge():
	var file = FileAccess.open(d_file, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
 
func _input(event):
	if !d_active:
		return

	if waiting_for_release:
		if event.is_action_released("ui_accept"):
			waiting_for_release = false
		return
	
	if event.is_action_pressed("ui_accept") and not event.is_echo():

		if text_tween and text_tween.is_running():
			text_tween.kill()
			$NinePatchRect/Text.visible_characters = -1
		else:
			next_script()
 
func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialouge):
		d_active = false
		$NinePatchRect.visible = false

		get_tree().paused = false
		emit_signal("dialouge_finished")
		return
	
	$NinePatchRect/Name.text = dialouge[current_dialogue_id]['name']
	$NinePatchRect/Text.text = dialouge[current_dialogue_id]['text']
	
	# ADDED: everything below is the typewriter animation
	$NinePatchRect/Text.visible_characters = 0
	if text_tween:
		text_tween.kill()
	text_tween = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	var text_length = $NinePatchRect/Text.text.length()
	var duration = text_length * 0.03
	text_tween.tween_property($NinePatchRect/Text, "visible_characters", text_length, duration)
 
