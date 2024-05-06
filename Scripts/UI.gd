extends Control

@onready var main_menu = $MainMenu
@onready var generation_menu = $GenerationMenu
@onready var hud = $HUD
@onready var back_ground = $BackGround
@onready var end_screen = $EndScreen
@onready var text_edit_seed = $GenerationMenu/ColorRect/VBoxContainer/Container_Seed/LineEdit_Seed
@onready var pause_menu = $PauseMenu

signal quit_application
signal start_game(newSeed: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	display_main_screen();

func _on_button_play_pressed():
	display_game_ui()

func _on_button_settings_pressed():
	pass # Replace with function body.

func _on_button_quit_pressed():
	quit_application.emit()

func _on_button_seed_validation_pressed():
	start_game.emit(text_edit_seed.text);
	generation_menu.visible = false;
	hud.visible = true;

signal main_screen_displayed

func display_main_screen():
	main_screen_displayed.emit()
	back_ground.visible = true;
	main_menu.visible = true;
	hud.visible = false;
	generation_menu.visible = false;
	end_screen.visible = false;
	pause_menu.visible = false;

func display_pause_menu():
	pause_menu.visible = true;

func display_end_screen():
	main_menu.visible = false;
	hud.visible = false;
	generation_menu.visible = false;
	end_screen.visible = true;
	pause_menu.visible = false;

func update_level(newLevel: int):
	$HUD/Container_Top/Label_LevelValue.text = str(newLevel);

func _on_button_exit_pressed():
	display_main_screen();

func display_game_ui():
	main_menu.visible = false;
	generation_menu.visible = true;
	pause_menu.visible = false;

func _on_button_resume_pressed():
	display_game_ui()
