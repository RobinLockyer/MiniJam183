extends Control

class_name DeckView

const deck_view_scene: Resource = preload("res://scenes/DeckView.tscn")
const card_display_scene: Resource = preload("res://scenes/CardDisplay.tscn")

var deck: Array[Card]
var onClickCallback = null

static func open(parent: Node, cardList: Array[Card], onClick = null) -> void:
	var deckview = deck_view_scene.instantiate()
	deckview.deck = cardList
	deckview.onClickCallback = onClick
	parent.add_child(deckview)

func _enter_tree() -> void:
	for i in range(deck.size()):
		var card_display = card_display_scene.instantiate()
		card_display.card = deck[i]
		card_display.index = i
		if onClickCallback:
			card_display.get_node("Card").pressed.connect(onClickCallback.bind(card_display))
		$PanelContainer/DeckDisplayContainer.add_child(card_display)

func close() -> void:
	get_parent().remove_child(self)
	
