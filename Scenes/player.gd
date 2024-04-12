extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var speed: float = 1000
var direction: Vector2

func _input(event):
	if (event.is_action_pressed("moveUp")):
		direction.y -= 1;
	if (event.is_action_pressed("moveDown")):
		direction.y += 1;
	if (event.is_action_pressed("moveRight")):
		direction.x += 1;
	if (event.is_action_pressed("moveLeft")):
		direction.x -= 1;
	
	direction = direction.normalized();

func _process(delta):
	position.x += direction.x * delta * speed;
	position.y += direction.y * delta * speed;
	direction = Vector2(0, 0)
