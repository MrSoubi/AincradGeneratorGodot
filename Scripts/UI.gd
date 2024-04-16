extends Control

@onready var main_menu = $MainMenu
@onready var generation_menu = $GenerationMenu
@onready var hud = $HUD
@onready var back_ground = $BackGround
@onready var end_screen = $EndScreen
@onready var text_edit_seed = $GenerationMenu/ColorRect/VBoxContainer/Container_Seed/LineEdit_Seed

signal quit_application
signal start_game(newSeed: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	displayMainScreen();

func _on_button_play_pressed():
	main_menu.visible = false;
	generation_menu.visible = true;

func _on_button_settings_pressed():
	pass # Replace with function body.

func _on_button_quit_pressed():
	quit_application.emit()

func _on_button_seed_validation_pressed():
	start_game.emit(text_edit_seed.text);
	generation_menu.visible = false;
	hud.visible = true;

func displayMainScreen():
	back_ground.visible = true;
	main_menu.visible = true;
	hud.visible = false;
	generation_menu.visible = false;
	end_screen.visible = false;

func displayEndScreen():
	main_menu.visible = false;
	hud.visible = false;
	generation_menu.visible = false;
	end_screen.visible = true;

func updateLevel(newLevel: int):
	$HUD/Container_Top/Label_LevelValue.text = str(newLevel);

func _on_button_exit_pressed():
	displayMainScreen();
