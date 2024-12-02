class_name GameOverMenu
extends Node2D


@onready var play_button: UIButton = $Buttons/Play/PlayButton
@onready var return_button: UIButton = $Buttons/Return/ReturnButton
@onready var score: Label = $Scoreboard/Score


func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	return_button.pressed.connect(_on_return_button_pressed)
	
	update_scoreboard()

func update_scoreboard() -> void:
	score.text = str(GameState.score)

func _on_play_button_pressed() -> void:
	GameState.reset_score()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	
func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
