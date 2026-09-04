extends Area2D
# NOTE: must extend Area2D (not CollisionShape2D) and be attached to the
# Room1 Area2D node itself — body_entered/body_exited only exist on Area2D.
 
# NEW: custom signal, connected from main.gd the same way Exit/Exit_back are
signal room_entered(target_level: int)
 
# NEW: set this in the Inspector to whichever level number this door leads to
@export var target_level: int = 1
 
# NEW: tracks whether the player is standing close enough to interact
var player_in_range = false
 
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
 
 
# NEW: connect this to Room1's own "body_entered" signal in the editor
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = true
 
# NEW: connect this to Room1's own "body_exited" signal in the editor
func _on_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_range = false
 
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# NEW: only fires when the player is in range AND presses the interact key,
	# instead of triggering automatically like Exit/Exit_back do
	if player_in_range and Input.is_action_just_pressed("chat"):
		emit_signal("room_entered", target_level)
 
