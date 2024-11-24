class_name Menu
extends Node2D


const BUTTON_CLICK_SOUND: Resource = preload(
	"res://Assets/Sounds/button_click.wav"
)

@onready var score: Label = $Scores/Score/Value
@onready var best_score: Label = $Scores/BestScore/Value
@onready var play_button: TextureButton = $Buttons/PlayButton
@onready var config_button: TextureButton = $Buttons/ConfigButton


func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	config_button.pressed.connect(_on_config_button_pressed)
	update_scores()

func _process(_delta: float) -> void:
	pass

func update_scores() -> void:
	score.text = str(GameState.score)
	best_score.text = str(GameState.best_score)

func _on_play_button_pressed() -> void:
	update_scores()
	GameState.reset_score()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	
func _on_config_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/config_menu.tscn")
