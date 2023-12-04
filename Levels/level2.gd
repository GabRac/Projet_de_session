extends Node2D

@onready var pause_menu = $Canvas/PauseMenu
@onready var debug_label = $Player/DebugMode
@onready var door_area = $doorArea
@onready var door_area_anim = $doorArea/AnimatedSprite2D

var paused = false
var debug = false


func _ready():
	door_area_anim.set_frame(8)

	
func _process(_delta):
	# Obtenez la liste des ennemis dans le groupe "Enemies"
	var enemies = get_tree().get_nodes_in_group("Enemies")

	# Vérifiez si le nombre d'ennemis est égal à 0
	if enemies.size() == 0:
		get_tree().change_scene_to_file("res://Levels/win.tscn")
		
		
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	if Input.is_action_just_pressed("debug"):
		debug = !debug
		toggle_debug_collisions(debug)
	if Input.is_action_just_pressed("skip"):
		get_tree().change_scene_to_file("res://Levels/win.tscn")
		
		
	if get_tree().debug_collisions_hint == true:
		debug_label.show()
		debug_label.text = "Debug Mode : ON"
	else:
		debug_label.text = "Debug Mode : OFF"
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		get_tree().paused = false
	else:
		pause_menu.show()
		get_tree().paused = true
		
	paused = !paused
	
# Toggle debug collisions
func toggle_debug_collisions(debug):
	get_tree().set_debug_collisions_hint(debug)
	get_tree().change_scene_to_file("res://Levels/level2.tscn")


