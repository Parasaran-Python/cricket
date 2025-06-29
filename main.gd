extends Node

# Game variables
var ball_node
var dialog_shown = false
var screen_size
var restart_dialog
var score = 0
var score_label

# Called when the node enters the scene tree for the first time.
func _ready():
	ball_node = $Ball
	screen_size = get_viewport().get_visible_rect().size
	
	# Create and setup score label
	score_label = Label.new()
	score_label.name = "ScoreLabel"
	score_label.text = "Score: 0"
	score_label.add_theme_font_size_override("font_size", 24)
	score_label.position = Vector2(screen_size.x - 150, 20)  # Top right position
	score_label.z_index = 100  # Make sure it's on top
	add_child(score_label)
	
	# Create and setup restart dialog
	restart_dialog = ConfirmationDialog.new()
	restart_dialog.name = "RestartDialog"
	restart_dialog.dialog_text = "Ball went out of bounds!\nScore: 0\n\nDo you want to restart the game?"
	restart_dialog.get_ok_button().text = "Restart"
	restart_dialog.get_cancel_button().text = "Quit"
	restart_dialog.process_mode = Node.PROCESS_MODE_WHEN_PAUSED  # Allow dialog to work when paused
	add_child(restart_dialog)
	
	# Connect dialog signals
	restart_dialog.confirmed.connect(_on_restart_confirmed)
	restart_dialog.canceled.connect(_on_restart_canceled)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ball_node and not dialog_shown:
		var ball_pos = ball_node.global_position
		
		# Check if ball is outside screen boundaries (with some margin)
		var margin = 100
		if (ball_pos.x < -margin or ball_pos.x > screen_size.x + margin or 
			ball_pos.y < -margin or ball_pos.y > screen_size.y + margin):
			ball_node.freeze = true  # Freeze physics temporarily
			ball_node.global_position = Vector2(576, 150)
			_show_restart_dialog()

func _show_restart_dialog():
	dialog_shown = true
	restart_dialog.dialog_text = "Ball went out of bounds!\nFinal Score: " + str(score) + "\n\nDo you want to restart the game?"
	restart_dialog.popup_centered()
	# Pause the game
	get_tree().paused = true

func _on_restart_confirmed():
	# Restart the game
	get_tree().paused = false
	dialog_shown = false
	_restart_game()

func _on_restart_canceled():
	# Quit the game
	get_tree().quit()

func _restart_game():
	# Reset score
	score = 0
	_update_score_display()
	
	# Properly reset the RigidBody2D
	ball_node.freeze = true  # Freeze physics temporarily
	ball_node.linear_velocity = Vector2.ZERO
	ball_node.angular_velocity = 0.0
	ball_node.freeze = false  # Unfreeze physics
	
	# Set initial velocity after unfreezing
	ball_node.linear_velocity = Vector2(-1000, 340)
	ball_node.angular_velocity = 10.0
	
	# Reset any accumulated forces
	ball_node.constant_force = Vector2.ZERO
	ball_node.constant_torque = 0.0

func _update_score_display():
	score_label.text = "Score: " + str(score)

# Function to play ball hitting sound
func _play_ball_hitting_sound():
	var audio_stream_player = $BallHit
	var audio_stream = load('res://ball_hit.mp3')
	audio_stream_player.stream = audio_stream
	audio_stream_player.volume_db = 24
	audio_stream_player.play()

func _ball_hit(body):
	# Check if the ball hit the bat (white bat)
	if body.name == "Bat":
		score += 1
		_update_score_display()
	
	_play_ball_hitting_sound()
