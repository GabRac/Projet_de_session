extends Control


func _on_play_sound_effect_btn_pressed() -> void:
	$sound_effect.play()


func _on_back_to_menu_pressed():
	ClickFx.button_click()
	get_tree().change_scene_to_file("res://Menus/menu.tscn")
