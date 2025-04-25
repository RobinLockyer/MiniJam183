extends Control

class_name DeckView

const deck_view_scene: Resource = preload("res://scenes/DeckView.tscn")

var deck: Array[Card]

static func open(parent: Node) -> void:
	parent.add_child(deck_view_scene.instantiate())

func _ready() -> void:
	for card in deck:
		$DeckDisplayContainer.add_child(card)

func close() -> void:
	get_parent().remove_child(self)
