extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Function to play ball hitting sound
func _play_ball_hitting_sound():
	var audio_stream_player = $BallHit
	var audio_stream = load('res://ball_hit.mp3')
	audio_stream_player.stream = audio_stream
	audio_stream_player.volume_db = 24
	audio_stream_player.play()


func _ball_hit(body):
	_play_ball_hitting_sound()
