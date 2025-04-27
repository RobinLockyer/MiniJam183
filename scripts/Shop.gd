extends Control

var deck: Array[Card]

func open_deckview() -> void:
	DeckView.open(self, deck)
	
func continue_to_level_map():
	get_tree().change_scene_to_file("res://scenes/LevelMap.tscn")
