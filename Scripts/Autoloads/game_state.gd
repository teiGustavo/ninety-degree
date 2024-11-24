extends Node


const SAVE_FILE_PATH: String = "user://savegame.save"
const VOLUMES_FILE_PATH: String = "user://volumes.save"
const MUSIC: AudioStream = preload("res://Assets/Sounds/music.wav")

var score: int = 0
var best_score: int = 0
var volumes: Dictionary = {
	"ui": 1,
	"sound": 1,
	"music": 1,
	"ambient_sound": 1,
}

@onready var root_viewport: Window = get_viewport()


func _ready() -> void:
	load_best_score()
	
	get_viewport().size_changed.connect(
		func() -> void: root_viewport = get_viewport()
	)
	
	set_all_audio_configs()

func increase_score(points: int = 1) -> void:
	score += points

func reset_score() -> void:
	score = 0

func update_best_score() -> void:
	if score > best_score:
		best_score = score

func save_best_score() -> void:
	JSONSaveManager.save(SAVE_FILE_PATH, {"best_score": best_score})

func load_best_score() -> void:
	var loaded_score: Variant = JSONSaveManager.load(
		SAVE_FILE_PATH, 
		"best_score"
	)
	
	if loaded_score:
		best_score = loaded_score

func save_volumes() -> void:
	JSONSaveManager.save(VOLUMES_FILE_PATH, volumes)

func load_volumes() -> void:
	var loaded_volumes: Variant = JSONSaveManager.load(VOLUMES_FILE_PATH)
		
	if loaded_volumes:
		volumes = loaded_volumes

func set_all_audio_configs() -> void:
	load_volumes()
	
	_config_audio_buses()
	_config_volumes()
	_play_backgorund_music()

func _config_audio_buses() -> void:
	SoundManager.set_default_ui_sound_bus("UI")
	SoundManager.set_default_music_bus("Music")
	SoundManager.set_default_sound_bus("Sound")
	SoundManager.set_default_ambient_sound_bus("Ambient Sound")
	
func _config_volumes() -> void:
	SoundManager.set_music_volume(volumes["music"])
	SoundManager.set_ui_sound_volume(volumes["ui"])
	SoundManager.set_sound_volume(volumes["sound"])
	SoundManager.set_ambient_sound_volume(volumes["ambient_sound"])

func _play_backgorund_music() -> void:
	SoundManager.play_music(MUSIC)
