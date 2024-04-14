extends Node

@export var tile_map: TileMap
@export var player: Node2D
@export var ui = Control

var level: int

func _ready():
	player.visible = false;
	tile_map.visible = false;
	level = 1;

func _on_ui_quit_application():
	get_tree().quit();

func _on_ui_start_game(newSeed):
	print("Start")
	ui.updateLevel(level)
	Randomizer.Initialize(newSeed);
	player.visible = true;
	tile_map.visible = true;
	tile_map.Gen(level);
	player.position = tile_map.getStartingPosition();

func _on_player_arrived_at_dungeon():
	level += 1;
	ui.updateLevel(level);
	tile_map.Gen(level);
	player.position = tile_map.getStartingPosition();
