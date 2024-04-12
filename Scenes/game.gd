extends Node

@export var tile_map: TileMap
@export var world: Node2D

func _ready():
	world.visible = false;
	pass;

func _on_ui_quit_application():
	get_tree().quit();

func _on_ui_start_game(newSeed):
	Randomizer.Initialize(newSeed);
	world.visible = true;
	tile_map.Gen(1);

