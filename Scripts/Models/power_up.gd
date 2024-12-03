class_name PowerUp
extends Resource


signal parent_changed

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

var parent: Node:
	set = _set_parent
var allowed: bool = true


func _init() -> void:
	parent_changed.connect(_on_parent_changed)

func apply() -> void:
	_assert_parent()
	SoundManager.play_sound(sound_when_applied)
	
func remove() -> void:
	_assert_parent()
	SoundManager.play_sound(sound_when_removed)

func _assert_parent() -> void:
	if not parent:
		push_error('Parent is not defined!')

func _get_name() -> String:
	return name.capitalize().to_pascal_case()

func _set_parent(value: Node) -> void:
	parent = value

	if parent:
		parent_changed.emit()

func _on_parent_changed() -> void:
	pass
