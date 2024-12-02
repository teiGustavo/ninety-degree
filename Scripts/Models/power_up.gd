class_name PowerUp
extends Resource


@export_range(1, 60, 0.5) var duration_in_seconds: float = 8
@export var name: String
@export var group: StringName

var target: Node2D
var allowed: bool = true


func apply() -> void:
	_assert_target()
	
func remove() -> void:
	_assert_target()

func _assert_target() -> void:
	if not target:
		push_error('Target is not defined!')
