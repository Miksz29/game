extends Area2D

@onready var third_indicator = $"../ThirdIndicator"
@onready var fourth_indicator = $"../FourthIndicator"

var triggered = false

func _ready() -> void:
	fourth_indicator.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player") and not triggered:
		triggered = true
		$Dialouge.start()

func _on_dialouge_dialouge_finished() -> void:
	third_indicator.hide()
	fourth_indicator.show()
	
