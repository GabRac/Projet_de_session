extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -200.0

@onready var _animation_player = $AnimationPlayer
@onready var _walk_sprite = $walk
@onready var _idle_sprite = $idle

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2 = Vector2.ZERO


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "ui_up", "ui_down")

	if direction.x != 0:
		velocity.x = direction.x * SPEED
		_animation_player.play("walk")
		_walk_sprite.visible = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animation_player.play("RESET")

	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	if direction.x != 0:
		_animation_player.play('walk')
		_idle_sprite.visible = false
	else:
		_animation_player.play('idle')
		_idle_sprite.visible = true
		_walk_sprite.visible = false

func update_facing_direction():
	if direction.x > 0:
		_walk_sprite.flip_h = false
		_idle_sprite.flip_h = false
	elif direction.x < 0:
		_walk_sprite.flip_h = true
		_idle_sprite.flip_h = true
