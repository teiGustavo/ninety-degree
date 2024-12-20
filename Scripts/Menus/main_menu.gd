class_name MainMenu
extends Node2D


@onready var score: Label = $Scoreboards/Score/Value
@onready var best_score: Label = $Scoreboards/BestScore/Value
@onready var play_button: UIButton = $Buttons/Play/PlayButton
@onready var config_button: UIButton = $Buttons/Config/ConfigButton
@onready var config_menu: ConfigMenu = $ConfigMenu


func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	config_button.pressed.connect(_on_config_button_pressed)
	
	update_scoreboards()

func update_scoreboards() -> void:
	score.text = str(GameState.score)
	best_score.text = str(GameState.best_score)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	
func _on_config_button_pressed() -> void:
	config_menu.show()
