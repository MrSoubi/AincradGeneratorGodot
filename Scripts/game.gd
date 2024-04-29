extends Node

@export var tile_map: TileMap
@export var player: Node2D
@export var ui = Control
@onready var world = $World

var level: int

func _ready():
	world.visible = false;
	level = 1;

func _on_ui_quit_application():
	get_tree().quit();

func _on_ui_start_game(newSeed):
	level = 1;
	ui.updateLevel(level)
	Randomizer.Initialize(newSeed);
	world.visible = true;
	tile_map.Gen(level);
	player.position = tile_map.getStartingPosition();

func _on_player_arrived_at_dungeon():
	level += 1;
	if (level > 15):
		ui.displayEndScreen();
		world.visible = false;
	else:
		ui.updateLevel(level);
		tile_map.Gen(level);
		player.position = tile_map.getStartingPosition();
