extends CharacterBody2D
class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var base_speed = 150
var run_speed = 250
var current_speed = base_speed
var UP = Vector2(0, -1)
var jumpforce = 400
var state_machine

signal facing_direction_changed(facing_right: bool)

# Stamina variables
var max_stamina = 100
var current_stamina = max_stamina
var stamina_regeneration_rate = 50
var stamina_timer

var stamina_bar : ProgressBar

func _ready():
	stamina_bar = $ProgressBar  # Assign the ProgressBar node
	stamina_timer = $stamina_timer

func _physics_process(delta):
	velocity.y += delta * gravity
	state_machine = $AnimationTree.get("parameters/playback")
	# Check for run input (Shift key)
	if is_on_floor():
		if Input.is_action_pressed("shift") and current_stamina > 0  and velocity.x != 0:
			current_speed = run_speed
			if is_on_floor():
				state_machine.travel("run")
				decrease_stamina(delta)
		else:
			current_speed = base_speed
			if is_on_floor():
				if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
					state_machine.travel("walk")
				else:
					state_machine.travel("idle")

	if Input.is_action_pressed("left"):
		velocity.x = -current_speed
		$AnimatedSprite2D.flip_h = true
	elif Input.is_action_pressed("right"):
		velocity.x = current_speed
		$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = 0

	emit_signal("facing_direction_changed", !$AnimatedSprite2D.flip_h)

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jumpforce
	else:
		if velocity.y == 0:
			state_machine.travel("land")
		elif velocity.y > 0:
			state_machine.travel("fall")
		else:
			state_machine.travel("jump")

	if Input.is_action_just_pressed("attack"):
		attack_player()

	move_and_slide()
	
func attack_player():
	state_machine.travel("attack")

# Function to decrease stamina over time
func decrease_stamina(delta):
	current_stamina = clamp(current_stamina - delta * stamina_regeneration_rate, 0, max_stamina)
	stamina_bar.value = current_stamina

	if current_stamina <= 0:
		stamina_timer.start()  #d Start a timer when stamina reaches 0

# Function to handle stamina regeneration when the timer expires
func _on_stamina_timer_timeout():
	current_stamina += 15  # Adjust the regeneration rate as needed
	stamina_bar.value = current_stamina

	if current_stamina < max_stamina:
		stamina_timer.start()  # Restart the timer if stamina is not yet at the maximum
	else:
		stamina_timer.stop()  # Stop the timer when stamina reaches the maximum

