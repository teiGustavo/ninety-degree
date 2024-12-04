class_name PowerUp
extends Resource


signal game_changed

const POWER_UP_APPLY: AudioStreamWAV = preload(
	"res://Assets/Sounds/power_up_apply.wav"
)
const POWER_UP_REMOVE: AudioStreamWAV = preload(
	"res://Assets/Sounds/power_up_remove.wav"
)

@export_range(1, 60, 0.5) var duration_in_seconds: float = 8
@export var name: String:
	get = _get_name
@export var texture: CompressedTexture2D
@export var sound_when_applied: AudioStream = POWER_UP_APPLY
@export var sound_when_removed: AudioStream = POWER_UP_REMOVE

var game: Game:
	set = _set_game


func _init() -> void:
	game_changed.connect(_on_game_changed)

func can_applied() -> bool:
	return true

func can_removed() -> bool:
	return true
	
func apply() -> void:
	_assert_game()
	SoundManager.play_sound(sound_when_applied)
	
func remove() -> void:
	_assert_game()
	SoundManager.play_sound(sound_when_removed)

func _assert_game() -> void:
	if not game:
		push_error('Parent is not defined!')

func _get_name() -> String:
	if not "power_up" in name.to_snake_case():
		name += " Power Up"
	
	return name.to_pascal_case()

func _set_game(value: Game) -> void:
	game = value

	if game:
		game_changed.emit()

func _on_game_changed() -> void:
	pass
