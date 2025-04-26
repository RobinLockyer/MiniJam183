extends Control

@export var label_target_value: Label
@export var label_current_value: Label
@export var hand_container: Node

var level_index: int = 0
var is_boss: bool = false
var target_number: int = 0
var current: float = 0
var draw_pile: Array[Card]
var deck_size: int = 15
var hand_size: int = 5

func _ready() -> void:
	label_target_value.text = str(target_number)
	update_current_value_label()
	draw_pile.shuffle()
	for i in deck_size:
		var card = Card.create_random()
		card.pressed.connect(card_clicked.bind(card))
		draw_pile.append(card)
	for i in hand_size:
		hand_container.add_child(draw_pile.pop_front())
	
func card_clicked(card: Card) -> void:
	current = card.operation.call(current, card.value)
	update_current_value_label()
	hand_container.remove_child(card)
	$VictoryContainer.visible = true
	
func update_current_value_label():
	label_current_value.text = str(current)
	
func continue_to_shop() -> void:
	get_tree().change_scene_to_file("res://scenes/Shop.tscn")
