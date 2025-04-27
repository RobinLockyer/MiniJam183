extends Control

@export var score_label: Label
@export var main_text: Label
@export var continue_button: Button

func _ready() -> void:
	score_label.text = str(SaveData.points)
	if SaveData.lives == 0:
		main_text.text = "Game Over"
		SaveData.reset()
		continue_button.text = "Menu"
		continue_button.pressed.connect(get_tree().change_scene_to_file.bind("res://scenes/Main.tscn"))
	else:
		SaveData.lives -= 1
		main_text.text = "Lives remaining: " + str(SaveData.lives)
		continue_button.text = "Continue"
		continue_button.pressed.connect(get_tree().change_scene_to_file.bind("res://scenes/LevelMap.tscn"))
	SaveData.save_game()
