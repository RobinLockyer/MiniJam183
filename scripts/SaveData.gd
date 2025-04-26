extends Node

var save_path: String = "user://save_game.cfg"
var config: ConfigFile = ConfigFile.new()

var current_level: int = 1
var points: int = 0

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
