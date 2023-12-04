extends Area2D

@onready var door_label = $Control/doorLabel
var entered = false


func _on_body_entered(body: PhysicsBody2D):
	entered = true
	door_label.visible = true


func _on_body_exited(body):
	entered = false
	door_label.visible = false
	
	
func _physics_process (_delta):
	if entered == true:
		if Input.is_action_just_pressed("enter"):
			get_tree().change_scene_to_file("res://Levels/level2.tscn")
