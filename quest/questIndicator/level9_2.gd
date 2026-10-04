extends Area2D

@onready var second_indicator = $"../SecondIndicator"
@onready var third_indicator = $"../ThirdIndicator"
var triggered = false

func _ready() -> void:
	third_indicator.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player") and not triggered:
		triggered = true
		$Dialouge.start()

func _on_dialouge_dialouge_finished() -> void:
	second_indicator.hide()
	third_indicator.show()
	
