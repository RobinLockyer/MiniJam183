extends Node

const MAIN_MENU_SCENE_PATH = "res://scenes/Main.tscn"

func _ready() -> void:
	print("Esc to Main is active.")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().current_scene.scene_file_path != MAIN_MENU_SCENE_PATH:
			get_tree().change_scene_to_file(MAIN_MENU_SCENE_PATH)
