extends Control


@onready var main = $"../../"


func _on_resume_pressed():
	main.pauseMenu()
	
func _on_menu_pressed():
	main.pauseMenu()
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
