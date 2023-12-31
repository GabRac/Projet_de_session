extends Area2D

@export var damage : int = 10
@export var player : Player
@export var facing_shape : FacingCollisionShape2D

func _ready():
	player.connect("facing_direction_changed", _on_player_facing_direction_changed)
	

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			$SwordSlashHit.play()
			child.hit(damage)

func _on_player_facing_direction_changed(facing_right : bool):
	if (facing_right):
		facing_shape.position = facing_shape.facing_right_position
	else:
		facing_shape.position = facing_shape.facing_left_position
	
