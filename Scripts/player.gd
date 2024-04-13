extends Node2D

signal arrived_at_dungeon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@export var speed: float = 16
var direction: Vector2 = Vector2(0,0)

func _input(event):
	if (event.is_action_pressed("moveUp")):
		direction.y = -1;
	if (event.is_action_pressed("moveDown")):
		direction.y = 1;
	if (event.is_action_pressed("moveRight")):
		direction.x = 1;
	if (event.is_action_pressed("moveLeft")):
		direction.x = -1;
	
	if (event.is_action_released("moveUp") or event.is_action_released("moveDown")):
		direction.y = 0;
	if (event.is_action_released("moveRight") or event.is_action_released("moveLeft")):
		direction.x = 0;
		
	direction = direction.normalized();

func _process(delta):
	position.x += direction.x * delta * speed;
	position.y += direction.y * delta * speed;


func _on_area_2d_body_entered(body):
	if (body is TileMap):
		arrived_at_dungeon.emit()
