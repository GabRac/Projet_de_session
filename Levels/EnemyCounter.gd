extends Label

var total_enemies_to_kill : int

func _ready():
	
	# Obtenez la liste des ennemis dans le groupe "Enemies"
	var enemies = get_tree().get_nodes_in_group("Enemies")

	# Initialisez total_enemies_to_kill avec la taille du groupe "Enemies"
	total_enemies_to_kill = enemies.size()

func _process(delta):
	# Obtenez la liste des ennemis dans le groupe "Enemies"
	var enemies = get_tree().get_nodes_in_group("Enemies")

	# Calculez le nombre d'ennemis tués
	var enemies_killed = total_enemies_to_kill - enemies.size()

	# Mettez à jour le texte du Label avec le nombre d'ennemis tués
	text = str(enemies_killed) + " / " + str(total_enemies_to_kill) + " killed"
