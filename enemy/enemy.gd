class_name Enemy extends CharacterBody2D

enum State {
	WALKING,
	DEAD,
	HIT
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

@export var receives_knockback : bool = true
@export var knockback_modifier : float = 0.1

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
	
	if velocity.x > 0.0:
		sprite.scale.x = 1.0
	elif velocity.x < 0.0:
		sprite.scale.x = -1.0

	update_animation()
	
	if (_state != State.DEAD):
		move_and_slide()

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

func receive_knockback(dmg_src_pos : Vector2, receive_damage : int):
	if receives_knockback:
		var knockback_direction = dmg_src_pos.direction_to(self.global_position)
		var knockback_strength = receive_damage + knockback_modifier
		var knockback = knockback_direction * knockback_strength
		
		global_position += knockback

func flash() -> void:
	shader.set_shader_parameter("flash_modifier", 0.8)
	flash_timer.start()

func _on_flash_timer_timeout() -> void:
	shader.set_shader_parameter("flash_modifier", 0)
	flash_timer.stop()

func stop() -> void:
	pass

func destroy() -> void:
	_state = State.DEAD

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
