extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	hide()

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	hide()
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	show()
	
func testEsc():
	if Input.is_action_just_pressed("Escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Escape") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
	
func _process(delta):
	testEsc()
