extends Node2D

var button_type = null


func _ready() -> void:
	Bgm.stop()
	print("HAS SAVE: ", SaveManager.has_save())
	$Button_Manager/Continue.visible = SaveManager.has_save()


func _on_start_pressed() -> void:
	button_type = "start"
	SaveManager.start_level = 1
	$fade_transition.show()
	$fade_transition/Fade_Timer.start()
	$fade_transition/AnimationPlayer.play("fade_out")
	
func _on_continue_pressed() -> void:
	button_type = "continue"
	SaveManager.start_level = SaveManager.load_level()
	$fade_transition.show()
	$fade_transition/Fade_Timer.start()
	$fade_transition/AnimationPlayer.play("fade_out")

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_fade_timer_timeout() -> void:
	if button_type == "start" or button_type == "continue":
		get_tree().create_timer(1.0).timeout.connect(Bgm.play)
		get_tree().change_scene_to_file("res://scenes/main.tscn")
