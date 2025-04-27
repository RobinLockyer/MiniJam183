extends VBoxContainer
class_name CardDisplay

var card: Card

func _ready() -> void:
	$Card.text = str(card)
	$Card.tooltip_text = "This card performs operation " + str(card)
	
func set_redraw_visible(val: bool) -> void:
	$Redraw.visible = val
