class_name Card

var value: int = 1
var operation: Callable = add
static var operations: Array[Callable] = [
	add, subtract, multiply, divide
]
static func create_random() -> Card:
	return Card.new(
		randi_range(1, 9),
		operations.pick_random()
	)
	
func _init(val: int, op :Callable):
	value = val
	operation = op

static func add(a: int, b: int) -> int:
	return a + b
	
static func subtract(a: int, b: int) -> int:
	return a - b

static func multiply(a: int, b: int) -> int:
	return a * b
	
static func divide(a: int, b: int) -> int:
	@warning_ignore("integer_division")
	return a / b
	
func _to_string() -> String:
	var opStr = "Unknown Op"
	match operation:
		add:
			opStr = "+"
		subtract:
			opStr = "-"
		multiply:
			opStr = "x"
		divide:
			opStr = "/"
	return str(opStr, " ", value)
