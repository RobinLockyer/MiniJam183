extends VBoxContainer
class_name CardDisplay

var card: Card
var cost: int = 0
var index: int = -1

func _ready() -> void:
	$Card.text = str(card)
	$Card.tooltip_text = "This card performs operation " + str(card)
	
func set_redraw_visible(val: bool) -> void:
	$Redraw.visible = val
	
func set_buy_visible(val: bool) -> void:
	$Buy.visible = val
