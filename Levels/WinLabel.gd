extends Label

var highlight_speed : float = 0.1

func _ready():
	if material is ShaderMaterial:
		update_highlight_speed()


func update_highlight_speed() -> void:
	if material is ShaderMaterial:		
		material.set_shader_parameter("time", highlight_speed)


func _physics_process(delta):
	highlight_speed += 0.5 * delta
	
	visible_characters += 60.0 * delta
	visible_characters = round(visible_characters)

	update_highlight_speed()
