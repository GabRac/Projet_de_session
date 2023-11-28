extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_instruction_button_pressed():
	ClickFx.button_click()
	get_tree().change_scene_to_file("res://Menus/Instructions.tscn")

func _on_start_button_pressed():
	ClickFx.button_click()
	get_tree().change_scene_to_file("res://Levels/world.tscn")


func _on_options_button_pressed():
	ClickFx.button_click()
	get_tree().change_scene_to_file("res://Menus/Options.tscn")


func _on_quit_button_pressed():
	ClickFx.button_click()
	get_tree().quit()
