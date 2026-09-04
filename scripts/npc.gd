extends CharacterBody2D
 
const speed = 30
var current_state = IDLE
 
var dir = Vector2.RIGHT
var start_pos
 
var is_roaming = true
var is_chatting =  false
 
var player
var player_in_chat_zone = false
 
enum{
	IDLE,
	NEW_DIR,
	MOVE
}
 
func _ready():
	randomize()
	start_pos = position
	
func _process(delta):
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
	elif current_state == 2 and !is_chatting:
		if dir.x == 1:
			$AnimatedSprite2D.play("walk_right")
		if dir.x == -1:
			$AnimatedSprite2D.play("walk_left")
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_up")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk_down")
	
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)
				
 
	if Input.is_action_just_pressed("chat") and player_in_chat_zone and !is_chatting:
		print("chatting with npc")
		$Dialouge.start()
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")
 
func choose(array):
	array.shuffle()
	return array.front()
 
func move(_delta):
	if !is_chatting:
		velocity = dir * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true
 
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = false
 
func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
 
func _on_dialouge_dialouge_finished() -> void:
	is_chatting = false
	is_roaming = true
 
