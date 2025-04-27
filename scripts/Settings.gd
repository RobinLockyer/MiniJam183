extends Control

@onready var mute_checkbox: CheckBox = $CenterContainer/VBoxContainer/MuteAudioCheckbox
@onready var delete_save_button: Button = $CenterContainer/VBoxContainer/DeleteSaveButton

func _ready() -> void:
	mute_checkbox.connect("toggled", Callable(self, "_on_mute_checkbox_toggled"))
	delete_save_button.connect("pressed", Callable(self, "_on_delete_save_button_pressed"))

func _on_mute_checkbox_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), button_pressed)
	print("Audio muted" if button_pressed else "Audio unmuted")

func _on_delete_save_button_pressed() -> void:
	if FileAccess.file_exists(SaveData.save_path):
		var dir = DirAccess.open("user://")
		if dir:
			dir.remove("save_game.cfg")
			print("Save file deleted.")
		else:
			print("Failed to open user directory.")
	else:
		print("No save file found to delete.")
