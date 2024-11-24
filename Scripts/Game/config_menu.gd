class_name ConfigMenu
extends Node2D


@onready var return_button: TextureButton = $VBoxContainer/ReturnButton
@onready var mute_sound_button: TextureButton = $VBoxContainer/HBoxContainer/MuteSoundButton
@onready var mute_music_button: TextureButton = $VBoxContainer/HBoxContainer/MuteMusicButton


func _ready() -> void:
	return_button.pressed.connect(_on_return_button_pressed)
	mute_sound_button.toggled.connect(_on_mute_sound_button_toggled)
	mute_music_button.toggled.connect(_on_mute_music_button_toggled)
	
func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_mute_music_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		SoundManager.set_music_volume(0)
	else:
		SoundManager.set_music_volume(1)
		
func _on_mute_sound_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		SoundManager.set_sound_volume(0)
	else:
		SoundManager.set_sound_volume(1)
