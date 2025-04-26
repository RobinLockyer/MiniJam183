extends Button
class_name CardDisplay

var card: Card

func _ready() -> void:
	text = str(card)
