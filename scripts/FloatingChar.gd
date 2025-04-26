extends Label

var velocity: Vector2 = Vector2.ZERO

func _ready():
	velocity = Vector2(randf_range(-100, 100), randf_range(-100, 100))
	modulate.a = 0.3 # Faded
	scale = Vector2.ONE * randf_range(0.75, 2.5)

func _process(delta):
	position += velocity * delta
	
	var screen_size = get_viewport_rect().size
	
	# Bounce horizontally
	if position.x < 0 or position.x + size.x > screen_size.x:
		velocity.x = -velocity.x
	# Bounce vertically
	if position.y < 0 or position.y + size.y > screen_size.y:
		velocity.y = -velocity.y
