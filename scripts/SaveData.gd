extends Node

var save_path: String = "user://save_game.cfg"
var config: ConfigFile = ConfigFile.new()

var current_level: int = 1
var points: int = 0
var deck: Array[Card] = [
	Card.new(1, Card.add),
	Card.new(2, Card.add),
	Card.new(3, Card.add),
	Card.new(4, Card.add),
	Card.new(5, Card.add),
	Card.new(6, Card.add),
	Card.new(7, Card.add),
	Card.new(8, Card.add),
	Card.new(9, Card.add),
	Card.new(1, Card.subtract),
	Card.new(2, Card.subtract),
	Card.new(2, Card.multiply),
	Card.new(2, Card.multiply),
	Card.new(3, Card.multiply),
	Card.new(2, Card.divide),
]

func save_game() -> void:
	config.set_value("game", "current_level", current_level)
	config.set_value("game", "points", points)
	config.save(save_path)
	print("Game saved!")

func load_game() -> void:
	var err = config.load(save_path)
	if err == OK:
		current_level = config.get_value("game", "current_level", 1)
		points = config.get_value("game", "points", 0)
		print("Game loaded! Level:", current_level, "Points:", points)
	else:
		print("No save file found. Creating default save...")
		save_game()
