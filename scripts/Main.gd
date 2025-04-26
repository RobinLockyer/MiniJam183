extends Control

func _ready() -> void:
	SaveData.load_game()
	print("Main menu loaded")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/LevelMap.tscn")

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Settings.tscn")
