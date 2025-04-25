extends Button
class_name Card

var value: int = 1
var operation: Callable = add
static var operations: Array[Callable] = [
	add, subtract, multiply, divide
]

func _ready() -> void:
	text = str(operation, " ", value)

static func create_random() -> Card:
	var card = Card.new()
	card.value = randi_range(1, 9)
	card.operation = operations.pick_random()
	return card

static func add(a: int, b: int) -> int:
	return a + b
	
static func subtract(a: int, b: int) -> int:
	return a - b

static func multiply(a: int, b: int) -> int:
	return a * b
	
static func divide(a: int, b: int) -> int:
	@warning_ignore("integer_division")
	return a / b
