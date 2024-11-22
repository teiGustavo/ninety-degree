class_name Boundaries
extends Node


signal changed

var screen_size: Vector2i:
	set = _set_screen_size
var spawn: PositionBound2 = PositionBound2.new()
var movement: PositionBound2 = PositionBound2.new()


func _init(size: Vector2i = GameState.root_viewport.size) -> void:
	screen_size = size

func _to_string() -> String:
	return 'Boundaries(spawn=%s, movement=%s)' \
		% [spawn, movement]

func _set_screen_size(value: Vector2i) -> void:
	screen_size = value
	
	var base_position: PositionBound2 = PositionBound2.new(
		Vector2.ZERO,
		screen_size,
		Bound2.from_float(PositionBound2.BASE_SAFETY_MARGIN)
	)
	
	spawn = base_position
	movement = base_position
	
	changed.emit()
