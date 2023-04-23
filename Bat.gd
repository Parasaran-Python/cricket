extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventScreenTouch and event.pressed == true:
		position.x = event.position.x
	elif event is InputEventScreenDrag:
		position.x = event.position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		position.x += 1
	elif Input.is_action_pressed("ui_left"):
		position.x -= 1
