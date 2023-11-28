extends CharacterBody2D

var _max_speed: float = 50
var _velocity: Vector2 = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
var _rotation_speed: float = 60
var _boundary_distance: float = 40
var _avoidance_distance: float = 200
var _mouse_avoidance_distance: float = 100  # Adjust this value for mouse avoidance distance
var _flock_group: String = "flock"
var _mouse_position: Vector2 = Vector2()  # Store the mouse position
var avoidance_vector: Vector2 = Vector2()
var avoidance_weight: float = 2.5

func _ready():
	position = Vector2(randi_range(100, 1000), randi_range(100, 500))
	rotation_degrees = randi()

func _process(delta: float) -> void:
	_update_mouse_position()
	_roam(delta)

func _roam(delta: float) -> void:
	avoidance_vector = Vector2()
	
	var screen_size: Vector2 = get_viewport_rect().size
	var new_position: Vector2 = floor(global_position + _velocity * _max_speed * delta)

	# Check if the new position is within the screen boundaries
	if new_position.x < _boundary_distance or new_position.x > screen_size.x - _boundary_distance or new_position.y < _boundary_distance or new_position.y > screen_size.y - _boundary_distance:
		_velocity = -_velocity
		rotation_degrees += 180
	else:
		_velocity = _velocity

	# Avoid other boids in the flock group
	
	var my_area: Area2D = $Area2D

	for body in my_area.get_overlapping_bodies():
		if body.is_in_group(_flock_group):
			var direction_to_other: Vector2 = (global_position - body.global_position).normalized()
			avoidance_vector += direction_to_other
		
	if avoidance_vector.length() > 0:
		avoidance_vector = avoidance_vector.normalized() * _max_speed * avoidance_weight
		_velocity += avoidance_vector * delta

	# Avoid the mouse position
	var direction_to_mouse: Vector2 = (_mouse_position - global_position).normalized()
	var mouse_avoidance_vector: Vector2 = Vector2()

	if _mouse_position.distance_to(global_position) < _mouse_avoidance_distance:
		mouse_avoidance_vector -= direction_to_mouse

	if mouse_avoidance_vector.length() > 0:
		mouse_avoidance_vector = mouse_avoidance_vector.normalized() * _max_speed
		_velocity += mouse_avoidance_vector * delta

	global_position += _velocity * _max_speed * delta
	rotation_degrees += randf_range(-_rotation_speed * delta, _rotation_speed * delta)

func _update_mouse_position() -> void:
	_mouse_position = get_global_mouse_position()


func _on_area_2d_body_entered(body):
	if body.is_in_group(_flock_group):
		var direction_to_other: Vector2 = (global_position - body.global_position).normalized()
		avoidance_vector += direction_to_other
		_velocity = _velocity.normalized()
