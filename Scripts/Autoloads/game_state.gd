extends Node


const MUSIC: AudioStream = preload("res://Assets/Sounds/music.wav")

var score: int = 0
var best_score: int = 0

@onready var root_viewport: Window = get_viewport()


func _ready() -> void:
	load_best_score()
	
	get_viewport().size_changed.connect(
		func() -> void: root_viewport = get_viewport()
	)
	
	config_audio_buses()
	config_volumes()
	play_backgorund_music()

func increase_score(points: int = 1) -> void:
	score += points

func reset_score() -> void:
	score = 0

func update_best_score() -> void:
	if score > best_score:
		best_score = score

func save_best_score() -> void:
	var save_file: FileAccess = FileAccess.open(
		"user://savegame.save", 
		FileAccess.WRITE
	)
	var json_string: String = JSON.stringify({"best_score": best_score})
	
	save_file.store_line(json_string)

func load_best_score() -> void:
	if not FileAccess.file_exists("user://savegame.save"):
		return
	
	var save_file: FileAccess = FileAccess.open(
		"user://savegame.save", 
		FileAccess.READ
	)
	var data = JSON.parse_string(save_file.get_as_text())
	
	if not data:
		return
	
	best_score = data["best_score"]

func config_audio_buses() -> void:
	SoundManager.set_default_ui_sound_bus("UI")
	SoundManager.set_default_music_bus("Music")
	SoundManager.set_default_sound_bus("Sound")
	SoundManager.set_default_ambient_sound_bus("Ambient Sound")
	
func config_volumes() -> void:
	SoundManager.set_music_volume(1)
	SoundManager.set_sound_volume(1)
	SoundManager.set_ambient_sound_volume(1)

func play_backgorund_music() -> void:
	SoundManager.play_music(MUSIC)
