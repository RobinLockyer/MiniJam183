extends Control

var current_level: int = 2
var level_buttons: Array
var boss_levels: Array = [4, 8]

func _ready():
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
	for i in range(level_buttons.size()):
		var button = level_buttons[i]
		var unlocked = (i <= current_level + 1) # <= current + 1
		
		if unlocked:
			button.disabled = false
			button.text = button.name
			button.modulate = Color(1, 1, 1, 1)
		else:
			button.disabled = true
			button.text = "?"
			button.modulate = Color(1, 1, 1, 0.5)

func _on_level_pressed(level_index: int):
	print("Clicked level:", level_index)
	var level_scene = load("res://scenes/Level.tscn").instantiate()

	# Set parameters
	level_scene.level_index = level_index
	level_scene.is_boss = boss_levels.has(level_index)
	level_scene.target_number = 24 # TODO

	# Change scene manually
	get_tree().root.add_child(level_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = level_scene
