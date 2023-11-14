extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -300.0
const JUMP_ANIM_DURATION = 0.8
const FALL_ANIM_SPEED = 0.8


const ANIM_WALK = "walk"
const ANIM_IDLE = "idle"
const ANIM_JUMP = "jump"
const ANIM_LAND = "land"
const ANIM_RUN = "run"

@onready var _animation_player = $AnimationPlayer
@onready var _walk_sprite = $walk
@onready var _idle_sprite = $idle
@onready var _jump_sprite = $jump
@onready var _land_sprite = $land
@onready var _run_sprite = $run

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = Vector2.ZERO
var was_on_floor = false
var is_jumping = false
var is_falling = false  # Flag for fall animation
var acceleration = 10

func _physics_process(delta):
	$ProgressBar.value += 0.1
	
	check_floor_state()
	process_jump(delta)
	apply_gravity(delta)
	handle_input()
	update_sprite_visibility()
	move_and_slide()
	update_facing_direction()
	

func check_floor_state():
	if is_on_floor() && !was_on_floor:
		_land_sprite.visible = true
		is_falling = true  # Player starts falling
		_animation_player.play(ANIM_LAND)  # Play the fall animation
		_animation_player.speed_scale = FALL_ANIM_SPEED
	was_on_floor = is_on_floor()

func process_jump(delta):
	if is_jumping:
		if velocity.y >= 0:
			velocity.y += gravity * delta
		else:
			is_jumping = false
			if !is_on_floor():
				is_falling = true  # Player starts falling
				_animation_player.stop()
				_animation_player.play(ANIM_JUMP, -1, 0.99)

	if !is_on_floor() && !is_jumping && velocity.y >= 0:
		is_falling = true  # Player starts falling
		_animation_player.play(ANIM_JUMP, -3, 0.99)
		_animation_player.speed_scale = FALL_ANIM_SPEED
	else:
		_animation_player.speed_scale = 1.0

func apply_gravity(delta):
	if !is_jumping:
		velocity.y += gravity * delta

func handle_input():
	if Input.is_action_just_pressed("ui_accept") && is_on_floor():
		start_jump()

	direction = Input.get_vector("left", "right", "ui_up", "ui_down")
	update_movement_animation()

func start_jump():
	velocity.y = JUMP_VELOCITY
	_animation_player.play(ANIM_JUMP)
	is_jumping = true

func update_movement_animation():
	if direction.x != 0:
		velocity.x = direction.x * SPEED
		if is_on_floor():
			if Input.is_action_pressed("shift") and direction.x != 0 and $ProgressBar.value > 0:
				velocity.x *= 1.5
				$ProgressBar.value -= 0.5
				_animation_player.play(ANIM_RUN)
				modulate = Color(0,1,1)
			else:
				_animation_player.play(ANIM_WALK)
				set_modulate(Color(1,1,1,1))
		else:
			_animation_player.play(ANIM_JUMP)
			set_modulate(Color(1,1,1,1))
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)  
		if is_on_floor():
			_animation_player.play(ANIM_IDLE)
		else:
			_animation_player.play(ANIM_JUMP)


func update_facing_direction():
	if direction.x > 0:
		_walk_sprite.flip_h = false
		_idle_sprite.flip_h = false
		_jump_sprite.flip_h = false
		_land_sprite.flip_h = false
		_run_sprite.flip_h = false

	elif direction.x < 0:
		_walk_sprite.flip_h = true
		_idle_sprite.flip_h = true
		_jump_sprite.flip_h = true
		_land_sprite.flip_h = true
		_run_sprite.flip_h = true

func update_sprite_visibility():
	_walk_sprite.visible = (_animation_player.current_animation == ANIM_WALK)
	_idle_sprite.visible = (_animation_player.current_animation == ANIM_IDLE)
	_jump_sprite.visible = (_animation_player.current_animation == ANIM_JUMP)
	_land_sprite.visible = (_animation_player.current_animation == ANIM_LAND)
	_run_sprite.visible = (_animation_player.current_animation == ANIM_RUN)
