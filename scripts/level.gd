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
var error_margin: int = 0

func _ready() -> void:
	label_target_value.text = str(target_number)
	update_current_value_label()
	draw_pile.shuffle()
	for i in deck_size:
		var card = Card.create_random()
		draw_pile.append(card)
	for i in hand_size:
		var card_display = CardDisplay.new()
		card_display.card = draw_pile.pop_front()
		card_display.pressed.connect(card_clicked.bind(card_display))
		hand_container.add_child(card_display)
		
	
func card_clicked(card_display: CardDisplay) -> void:
	current = card_display.card.operation.call(current, card_display.card.value)
	update_current_value_label()
	hand_container.remove_child(card_display)
	var target_diff: int = abs(target_number - current)
	if target_diff <= error_margin:
		$VictoryContainer.visible = true
		var points = error_margin - target_diff + level_index + 1
		SaveData.points += points
		$VictoryContainer/VBoxContainer/BoxContainer/points_value_label.text = str(points)
		
	
func update_current_value_label():
	label_current_value.text = str(current)
	
func continue_to_shop() -> void:
	get_tree().change_scene_to_file("res://scenes/Shop.tscn")
	
func open_deckview() ->void:
	DeckView.open(self, draw_pile)
