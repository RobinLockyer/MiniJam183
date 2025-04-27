extends Control

class_name DeckView

const deck_view_scene: Resource = preload("res://scenes/DeckView.tscn")
const card_display_scene: Resource = preload("res://scenes/CardDisplay.tscn")

var deck: Array[Card]

static func open(parent: Node, cardList: Array[Card]) -> void:
	var deckview = deck_view_scene.instantiate()
	deckview.deck = cardList
	parent.add_child(deckview)

func _enter_tree() -> void:
	for card in deck:
		var card_display = card_display_scene.instantiate()
		card_display.card = card
		$PanelContainer/DeckDisplayContainer.add_child(card_display)

func close() -> void:
	get_parent().remove_child(self)
	
