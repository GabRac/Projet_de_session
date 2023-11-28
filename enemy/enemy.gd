class_name Enemy extends CharacterBody2D

enum State {
	WALKING,
	DEAD,
}

const WALK_SPEED = 50.0
const CHASE_SPEED = 100.0

var _state := State.WALKING
var _player = null

@onready var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var platform_detector := $PlatformDetector as RayCast2D
@onready var floor_detector_left := $FloorDetectorLeft as RayCast2D
@onready var floor_detector_right := $FloorDetectorRight as RayCast2D
@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var flash_timer := $FlashTimer as Timer
@onready var shader = sprite.material as ShaderMaterial

func _physics_process(delta: float) -> void:
	chase_player()
	walk()

	velocity.y += gravity * delta
	if not floor_detector_left.is_colliding():
		velocity.x = WALK_SPEED
	elif not floor_detector_right.is_colliding():
		velocity.x = -WALK_SPEED

	if is_on_wall():
		velocity.x = -velocity.x

	move_and_slide()
	
	if velocity.x > 0.0:
		sprite.scale.x = 1.0
	elif velocity.x < 0.0:
		sprite.scale.x = -1.0

	update_animation()

func chase_player() -> void:
	if _player:
		var player_direction = (_player.position - self.position).normalized()
		velocity.x = player_direction.x * CHASE_SPEED
		animation_player.speed_scale = 4
	else:
		animation_player.speed_scale = 1

func walk() -> void:
	if _state == State.WALKING and velocity.is_zero_approx():
		velocity.x = WALK_SPEED

func update_animation() -> void:
	var animation := get_new_animation()
	if animation != animation_player.current_animation:
		animation_player.play(animation)

func flash() -> void:
	shader.set_shader_parameter("flash_modifier", 0.8)
	flash_timer.start()

func _on_flash_timer_timeout() -> void:
	shader.set_shader_parameter("flash_modifier", 0)
	flash_timer.stop()

func stop() -> void:
	velocity = Vector2.ZERO

func destroy() -> void:
	_state = State.DEAD
	stop()

func get_new_animation() -> StringName:
	var animation_new: StringName
	if _state == State.WALKING:
		if velocity.x == 0:
			animation_new = &"idle"
		else:
			animation_new = &"walk"
	else:
		animation_new = &"destroy"
	return animation_new

func _on_detect_player_body_entered(body) -> void:
	if body.name == "Player":
		_player = body

func _on_detect_player_body_exited(body) -> void:
	if body.name == "Player":
		_player = null
