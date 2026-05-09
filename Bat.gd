extends StaticBody2D

# Variables for screen boundaries
var screen_size
var bat_width

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	# Get bat width from collision shape
	var collision_shape = $CollisionShape2D.shape as RectangleShape2D
	bat_width = collision_shape.size.x

func _unhandled_input(event):
	if event is InputEventScreenTouch and event.pressed == true:
		var new_x = event.position.x
		var clamped_x = clamp(new_x, bat_width / 2, screen_size.x - bat_width / 2)
		if can_move_to(clamped_x):
			position.x = clamped_x
	elif event is InputEventScreenDrag:
		var new_x = event.position.x
		var clamped_x = clamp(new_x, bat_width / 2, screen_size.x - bat_width / 2)
		if can_move_to(clamped_x):
			position.x = clamped_x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_x = position.x
	
	if Input.is_action_pressed("ui_right"):
		new_x += 20
	elif Input.is_action_pressed("ui_left"):
		new_x -= 20
	
	# Apply boundary constraints
	var clamped_x = clamp(new_x, bat_width / 2, screen_size.x - bat_width / 2)
	
	# Only move if there's no wall collision
	if can_move_to(clamped_x):
		position.x = clamped_x

# Function to check if the bat can move to a new x position without hitting walls
func can_move_to(new_x: float) -> bool:
	var space_state = get_world_2d().direct_space_state
	var bat_collision_shape = $CollisionShape2D.shape as RectangleShape2D
	
	# Create a query to check for collisions at the new position
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = bat_collision_shape
	query.transform = Transform2D(0, Vector2(new_x, position.y))
	query.collision_mask = 1  # Check collision layer 1 (walls)
	query.exclude = [self]  # Don't collide with self
	
	var result = space_state.intersect_shape(query)
	return result.is_empty()  # Return true if no collision detected
