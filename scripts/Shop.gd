extends Control

@export var label_points_value: Label
@export var available_cards: Container

@export var num_cards_available: int = 5
@export var remove_card_cost: int = 5
@export var life_cost = 10
const card_display_scene: Resource = preload("res://scenes/CardDisplay.tscn")

func _ready() -> void:
	update_label_points_value()
	for i  in range(num_cards_available):
		var display = card_display_scene.instantiate()
		display.card = Card.create_random()
		display.cost = randi_range(1, 9)
		display.get_node("Buy").pressed.connect(buy_card.bind(display))
		display.get_node("Buy").text += " " + str(display.cost)
		display.set_buy_visible(true)
		available_cards.add_child(display)

func buy_card(display: CardDisplay) -> void:
	if display.cost <= SaveData.points:
		SaveData.deck.append(display.card)
		SaveData.points -= display.cost
		update_label_points_value()
		display.queue_free()

func open_deckview() -> void:
	DeckView.open(self, SaveData.deck)
	
func continue_to_level_map():
	get_tree().change_scene_to_file("res://scenes/LevelMap.tscn")
	
func update_label_points_value() -> void:
	label_points_value.text = str(SaveData.points)
	
func open_remove_card_menu() -> void:
	if remove_card_cost <= SaveData.points:
		SaveData.points -= remove_card_cost
		update_label_points_value()
		print("Opened")
		DeckView.open(self, SaveData.deck, remove_card)
		
func remove_card(card_display: CardDisplay) -> void:
	SaveData.deck.remove_at(card_display.index)
	$DeckView.queue_free()

func buy_life() -> void:
	if SaveData.points >= life_cost and SaveData.lives < SaveData.max_lives:
		SaveData.points -= life_cost
		SaveData.lives += 1
		SaveData.save_game()
		update_label_points_value()
