extends Control

@export var label_target_value: Label
@export var label_current_value: Label
@export var hand_container: Node
@export var victory_container: Node
@export var points_value_label: Label

var level_index: int = 0
var is_boss: bool = false
var target_number: int = 0
var current: float = 0
var draw_pile: Array[Card]
var hand_size: int = 6
var error_margin: int = 0
var remaining_redraws: int = 2

var card_display_scene: Resource = preload("res://scenes/CardDisplay.tscn")

func _ready() -> void:
	label_target_value.text = str(target_number)
	update_current_value_label()
	draw_pile = SaveData.deck.duplicate()
	draw_pile.shuffle()
	for i in hand_size:
		draw_card()
		
func draw_card() -> void:
	var card_display: CardDisplay = card_display_scene.instantiate()
	card_display.card = draw_pile.pop_front()
	card_display.get_children()[0].pressed.connect(card_clicked.bind(card_display))
	card_display.get_children()[1].pressed.connect(card_redraw.bind(card_display))
	if remaining_redraws > 0:
		card_display.set_redraw_visible(true)
	hand_container.add_child(card_display)
		
	
func card_clicked(card_display: CardDisplay) -> void:
	current = card_display.card.operation.call(current, card_display.card.value)
	update_current_value_label()
	hand_container.remove_child(card_display)
	var target_diff: int = abs(target_number - current)
	if target_diff <= error_margin:
		victory_container.visible = true
		var points = error_margin - target_diff + level_index + 1
		SaveData.points += points
		points_value_label.text = str(points)
		SaveData.current_level += 1
		SaveData.save_game()
		
func card_redraw(card_display: CardDisplay) -> void:
	if remaining_redraws > 0:
		card_display.queue_free()
		draw_card()
		remaining_redraws -= 1
		if remaining_redraws <= 0:
			for display in hand_container.get_children():
				display.set_redraw_visible(false)
	
func update_current_value_label():
	label_current_value.text = str(current)
	
func continue_to_shop() -> void:
	get_tree().change_scene_to_file("res://scenes/Shop.tscn")
	
func open_deckview() -> void:
	DeckView.open(self, draw_pile)
