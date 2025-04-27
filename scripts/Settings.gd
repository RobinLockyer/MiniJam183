extends Control

@onready var mute_checkbox: CheckBox = $Panel/CenterContainer/VBoxContainer/MuteAudioCheckbox
@onready var delete_save_button: Button = $Panel/CenterContainer/VBoxContainer/DeleteSaveButton

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
			var error = dir.remove(SaveData.save_path.get_file())
			if error == OK:
				print("Save file deleted.")
				SaveData.reset()
			else:
				print("Failed to delete save file. Error code:", error)
		else:
			print("Failed to open user directory.")
	else:
		print("No save file found to delete.")
