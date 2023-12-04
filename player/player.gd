extends CharacterBody2D

class_name Player

signal healthChanged

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var base_speed = 150
var run_speed = 200
var current_speed = base_speed
var UP = Vector2(0, -1)
var jumpforce = 300
var state_machine

signal facing_direction_changed(facing_right: bool)

@export var knockbackPower : int = 500
@onready var hurtBox = $hurtBox

# Health variables
var hurtTimer
@export var max_health = 100
@onready var current_health : int = max_health

# Stamina variables
var max_stamina = 100
var current_stamina = max_stamina
var stamina_regeneration_rate = 50
var stamina_timer

var stamina_bar : ProgressBar

var isHurt : bool = false

func _ready():
	hurtTimer = $hurtTimer
	stamina_bar = $stamina_bar
	stamina_timer = $stamina_timer

func _physics_process(delta):
	velocity.y += delta * gravity
	state_machine = $AnimationTree.get("parameters/playback")
	# Check for run input
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
	
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "AttackPlayer":
				hurtByEnemy(area)
	
	
func hurtByEnemy(area):
	current_health -= 10
	if current_health < 0:
		current_health = max_health
		
	isHurt = true
	healthChanged.emit()
	
	knockback(area.get_parent().velocity)
	hurtTimer.start()
	await hurtTimer.timeout
	isHurt = false
	
	
func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
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
	if current_speed == base_speed:
		current_stamina += 15  # Adjust the regeneration rate as needed
		
	stamina_bar.value = current_stamina

	if current_stamina < max_stamina:
		stamina_timer.start()  # Restart the timer if stamina is not yet at the maximum
	else:
		stamina_timer.stop()  # Stop the timer when stamina reaches the maximum



func _on_hurt_timer_timeout():
	if current_health < max_stamina:
		print(current_health)
		print(max_stamina)
		print("test")
		current_health += 20
	
	healthChanged.emit()
