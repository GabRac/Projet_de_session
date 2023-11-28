extends Node

class_name Damageable

var enemySprite : Sprite2D = null
var spriteMaterial : ShaderMaterial = null
var enemyRef : Enemy = null

@export var health : float = 20 :
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

var death_duration : float = 0.5  # Durée de l'animation de mort en secondes

func _ready():
	enemyRef = get_parent()
	enemySprite = get_parent().get_node("Sprite2D")
	if enemySprite:
		spriteMaterial = enemySprite.material

func hit(damage : int):
	health -= damage
	enemyRef.flash()

	if (health <= 0):
		if spriteMaterial:
			# Commencer l'animation de mort en ajustant death_progress graduellement
			get_node("DeathTimer").wait_time = death_duration / 100.0  # Ajuster le facteur de division pour une animation plus fluide
			get_node("DeathTimer").start()


func _on_death_timer_timeout():
	# Augmenter death_progress graduellement jusqu'à atteindre 1
	var progress = spriteMaterial.get_shader_parameter("death_progress")
	progress = clamp(progress + 0.1, 0, 1)  # Ajuster la valeur d'incrémentation pour une animation plus fluide
	spriteMaterial.set_shader_parameter("death_progress", progress)

	if progress >= 1:
		enemyRef.destroy()
