class_name ConfigMenu
extends Node2D


@onready var mute_sound_button: UIButton = $Buttons/HBoxContainer/MuteSound/MuteSoundButton
@onready var mute_music_button: UIButton = $Buttons/HBoxContainer/MuteMusic/MuteMusicButton
@onready var return_button: UIButton = $Buttons/Return/ReturnButton


func _ready() -> void:
	return_button.pressed.connect(_on_return_button_pressed)
	mute_sound_button.toggled.connect(_on_mute_sound_button_toggled)
	mute_music_button.toggled.connect(_on_mute_music_button_toggled)
	
	_set_buttons_state()

func _set_buttons_state() -> void:
	mute_sound_button.set_pressed_no_signal(not GameState.volumes["sound"])
	mute_music_button.set_pressed_no_signal(not GameState.volumes["music"])
	
func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_mute_sound_button_toggled(toggled_on: bool) -> void:
	var volume: int = not int(toggled_on)
	
	SoundManager.set_sound_volume(volume)
	SoundManager.set_ui_sound_volume(volume)
	
	GameState.volumes["sound"] = volume
	GameState.volumes["ui"] = volume
	GameState.save_volumes()

func _on_mute_music_button_toggled(toggled_on: bool) -> void:
	var volume: int = not int(toggled_on)
	
	SoundManager.set_music_volume(volume)
	
	GameState.volumes["music"] = volume
	GameState.save_volumes()
