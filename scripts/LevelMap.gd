extends Control

var level_buttons: Array
var boss_levels: Array = [4, 8]

func _ready():
	SaveData.load_game()
	level_buttons = [
		$CenterContainer/MarginContainer/GridContainer/Level1Button,
		$CenterContainer/MarginContainer/GridContainer/Level2Button,
		$CenterContainer/MarginContainer/GridContainer/Level3Button,
		$CenterContainer/MarginContainer/GridContainer/Level4Button,
		$CenterContainer/MarginContainer/GridContainer/BossButton,
		$CenterContainer/MarginContainer/GridContainer/Level6Button,
		$CenterContainer/MarginContainer/GridContainer/Level7Button,
		$CenterContainer/MarginContainer/GridContainer/Level8Button,
		$CenterContainer/MarginContainer/GridContainer/FinalBossButton
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

		var unlocked = (i <= current_level + 1)
		var is_current = (i == current_level)
		var is_next = (i == current_level + 1)
		var is_completed = (i < current_level)

		if unlocked:
			button.text = "Level %d\nValue: %d" % [i + 1, value]
			if is_boss:
				button.text += "\n (Boss)"

			if is_completed:
				button.modulate = Color(0.4, 1, 0.4, 1) # Green
			elif is_current:
				button.modulate = Color(0.4, 0.6, 1, 1) # Blue
			elif is_next:
				button.modulate = Color(1, 1, 1, 1) # White

			# Clickable only if current
			button.disabled = not is_current

			# Cursor and tooltip
			if is_current:
				button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
				button.tooltip_text = "This is the current level!"
			elif is_completed:
				button.mouse_default_cursor_shape = Control.CURSOR_ARROW
				button.tooltip_text = "Completed!"
			elif is_next:
				button.mouse_default_cursor_shape = Control.CURSOR_ARROW
				button.tooltip_text = "This is the next level!"
		else:
			# If locked
			button.disabled = true
			button.text = "?"
			button.modulate = Color(1, 1, 1, 0.5)
			button.mouse_default_cursor_shape = Control.CURSOR_ARROW
			button.tooltip_text = "Locked!"
			
		if is_boss:
			var style = StyleBoxFlat.new()
			style.bg_color = Color(1, 0.3, 0.3, 1)
			style.border_color = Color(1, 0.3, 0.3) # Red border
			style.border_width_top = 4
			style.border_width_bottom = 4
			style.border_width_left = 4
			style.border_width_right = 4

			button.add_theme_stylebox_override("normal", style)
			button.add_theme_stylebox_override("hover", style)
			button.add_theme_stylebox_override("pressed", style)
			button.add_theme_stylebox_override("focus", style)

func _on_level_pressed(level_index: int):
	print("Clicked level:", level_index)
	var level_scene = load("res://scenes/Level.tscn").instantiate()

	var level_data = SaveData.levels[level_index]

	level_scene.level_index = level_index
	level_scene.is_boss = level_data["is_boss"]
	level_scene.target_number = level_data["value"]

	get_tree().root.add_child(level_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = level_scene
