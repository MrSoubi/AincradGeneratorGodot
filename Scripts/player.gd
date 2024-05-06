extends RigidBody2D

signal arrived_at_dungeon

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
@onready var tile_map = $"../TileMap"

@export var speed: float = 16
var direction: Vector2 = Vector2(0,0)
var tile_position: Vector2i;
var can_move = true;

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
	move_and_collide(direction)
	tile_position = tile_map.local_to_map(position);
	tile_position.x += (tile_map.size / 2);
	tile_position.y += (tile_map.size / 2);



func _on_area_2d_body_entered(body):
	if (body is TileMap):
		print(body.dungeon_Pos)
		if (body.dungeon_Pos == tile_position or
			body.dungeon_Pos == tile_position + Vector2i(-1, -1) or
			body.dungeon_Pos == tile_position + Vector2i(-1, 0) or
			body.dungeon_Pos == tile_position + Vector2i(-1, 1) or
			body.dungeon_Pos == tile_position + Vector2i(0, -1) or
			body.dungeon_Pos == tile_position + Vector2i(0, 1) or
			body.dungeon_Pos == tile_position + Vector2i(1, -1) or
			body.dungeon_Pos == tile_position + Vector2i(1, 0) or
			body.dungeon_Pos == tile_position + Vector2i(1, 1)):
			arrived_at_dungeon.emit()
