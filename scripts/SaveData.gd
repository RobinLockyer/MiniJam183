extends Node

var save_path: String = "user://save_game.cfg"
var config: ConfigFile = ConfigFile.new()

var current_level: int = 0
var points: int = 0
var levels: Array = []
var boss_levels: Array = [4, 8]

func save_game() -> void:
	config.set_value("game", "current_level", current_level)
	config.set_value("game", "points", points)
	config.set_value("game", "levels", levels)
	config.save(save_path)
	print("Game saved!")

func load_game() -> void:
	var err = config.load(save_path)
	if err == OK:
		current_level = config.get_value("game", "current_level", 0)
		points = config.get_value("game", "points", 0)
		levels = config.get_value("game", "levels", [])

		if levels.is_empty():
			print("No level data found, generating...")
			generate_levels()
			save_game()
		else:
			print("Game and levels loaded!")

	else:
		print("No save file found. Generating default save...")
		generate_levels()
		save_game()

func generate_levels() -> void:
	levels.clear()
	for i in range(9):
		var level_data = {
			"value": 24 if i == 0 else randi_range(0, 100),
			"is_boss": boss_levels.has(i)
		}
		levels.append(level_data)
