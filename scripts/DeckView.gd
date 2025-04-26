extends Control

class_name DeckView

const deck_view_scene: Resource = preload("res://scenes/DeckView.tscn")

var deck: Array[Card]

static func open(parent: Node, cardList: Array[Card]) -> void:
	print("open")
	var deckview = deck_view_scene.instantiate()
	deckview.deck = cardList
	parent.add_child(deckview)

func _enter_tree() -> void:
	for card in deck:
		var card_display = CardDisplay.new()
		card_display.card = card
		$PanelContainer/DeckDisplayContainer.add_child(card_display)

func close() -> void:
	get_parent().remove_child(self)
	
