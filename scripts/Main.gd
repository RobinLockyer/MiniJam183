extends Control

const CHARS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "-", "*"]
const SPAWN_COUNT = 30

@onready var floating_char_scene = preload("res://scenes/FloatingChar.tscn")

func _ready() -> void:
	SaveData.load_game()
	print("Main menu loaded")

	# Spawn floating chars
	for i in range(SPAWN_COUNT):
		spawn_floating_char()

func spawn_floating_char():
	var char_instance = floating_char_scene.instantiate()
	char_instance.text = CHARS[randi() % CHARS.size()]
	var screen_size = get_viewport_rect().size
	char_instance.position = Vector2(
		randf_range(0, screen_size.x),
		randf_range(0, screen_size.y)
	)
	add_child(char_instance)
	char_instance.z_index = 1 # Make sure it's behind buttons
	
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/LevelMap.tscn")

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Settings.tscn")

func _on_deck_button_pressed() -> void:
	DeckView.open(self, SaveData.deck)
