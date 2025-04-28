extends Label

func _process(_delta: float) -> void:
	text = str(int($Timer.time_left))

func timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
