class_name PowerUp
extends Resource


const POWER_UP_APPLY: AudioStreamWAV = preload(
	"res://Assets/Sounds/power_up_apply.wav"
)
const POWER_UP_REMOVE: AudioStreamWAV = preload(
	"res://Assets/Sounds/power_up_remove.wav"
)

@export_range(1, 60, 0.5) var duration_in_seconds: float = 8
@export var name: String:
	get = _get_name
@export var target_group: StringName = "player"
@export var texture: CompressedTexture2D
@export var sound_when_applied: AudioStream = POWER_UP_APPLY
@export var sound_when_removed: AudioStream = POWER_UP_REMOVE

var target: Node2D
var allowed: bool = true


func apply() -> void:
	_assert_target()
	SoundManager.play_sound(sound_when_applied)
	
func remove() -> void:
	_assert_target()
	SoundManager.play_sound(sound_when_removed)

func _assert_target() -> void:
	if not target:
		push_error('Target is not defined!')

func _get_name() -> String:
	return name.capitalize().to_pascal_case()
