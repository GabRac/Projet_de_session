extends Area2D

@export var damage : int = 10

func _ready():
	pass
	


func _on_body_entered(body):
	print("Body entered:", body)
	print("Body name:", body.name)
	for child in body.get_children():
		print("Child:", child)
		if child is Damageable:
			child.hit(damage)
