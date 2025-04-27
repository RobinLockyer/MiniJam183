extends Control

var level_buttons: Array
var boss_levels: Array = [4, 8]

func _ready():
	SaveData.load_game()
	level_buttons = [
		$Panel/CenterContainer/MarginContainer/GridContainer/Level1Button,
		$Panel/CenterContainer/MarginContainer/GridContainer/Level2Button,
		$Panel/CenterContainer/MarginContainer/GridContainer/Level3Button,
		$Panel/CenterContainer/MarginContainer/GridContainer/Level4Button,
		$Panel/CenterContainer/MarginContainer/GridContainer/BossButton,
		$Panel/CenterContainer/MarginContainer/GridContainer/Level6Button,
		$Panel/CenterContainer/MarginContainer/GridContainer/Level7Button,
		$Panel/CenterContainer/MarginContainer/GridContainer/Level8Button,
		$Panel/CenterContainer/MarginContainer/GridContainer/FinalBossButton
	]

	for i in range(level_buttons.size()):
		var button = level_buttons[i]
		if button == null:
			print("ERROR: Missing level button at index", i)
		else:
			button.connect("pressed", Callable(self, "_on_level_pressed").bind(i))

	update_level_buttons()

func update_level_buttons():
	var current_level = SaveData.current_level

	for i in range(level_buttons.size()):
		var button = level_buttons[i]
		var level_data = SaveData.levels[i]
		var value = level_data["value"]
		var is_boss = level_data["is_boss"]

		var is_completed = (i < current_level)
		var is_current = (i == current_level)
		var is_next = (i == current_level + 1)
		var is_unlocked = (i <= current_level + 1)

		# Default (Locked)
		button.disabled = true
		button.mouse_default_cursor_shape = Control.CURSOR_ARROW
		button.tooltip_text = "Locked!"
		button.text = "?"

		if is_unlocked:
			button.text = "Level %d\nValue: %d" % [i + 1, value]
			if is_boss:
				button.text += "\n ☠"
			if is_completed:
				button.text = button.text + "\n ✓"
				button.tooltip_text = "Completed!"
			elif is_current:
				button.tooltip_text = "This is the current level!"
				button.disabled = false
				button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
			elif is_next:
				button.text = button.text + "\n 🔒"
				button.tooltip_text = "This is the next level!"

func _on_level_pressed(level_index: int):
	print("Clicked level:", level_index)
	var level_scene = load("res://scenes/Level.tscn").instantiate()

	var level_data = SaveData.levels[level_index]

	level_scene.level_index = level_index
	level_scene.is_boss = level_data["is_boss"]
	level_scene.target_number = level_data["value"]
	level_scene.error_margin = level_data["error_margin"]

	get_tree().root.add_child(level_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = level_scene
