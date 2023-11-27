extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = 150
var UP = Vector2(0,-1)
var jumpforce = 400
var state_machine

signal facing_direction_changed(facing_right : bool)


func _physics_process(delta):
	velocity.y += delta * gravity
	
	state_machine = $AnimationTree.get("parameters/playback")
	
	if Input.is_action_pressed("left"):
		velocity.x = -speed
		$AnimatedSprite2D.flip_h =  true
		state_machine.travel("walk")
	elif Input.is_action_pressed("right"):
		velocity.x = speed
		$AnimatedSprite2D.flip_h =  false
		state_machine.travel("walk")
	else:
		velocity.x = 0
		state_machine.travel("idle")
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
