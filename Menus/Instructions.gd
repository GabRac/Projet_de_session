extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Menus/menu.tscn")


func _on_back_to_menu_pressed():
	ClickFx.button_click()
	get_tree().change_scene_to_file("res://Menus/menu.tscn")
