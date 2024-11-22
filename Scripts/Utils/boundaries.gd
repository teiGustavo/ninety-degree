class_name Boundaries
extends Node


signal changed

var screen_size: Vector2i:
	set = _set_screen_size
var spawn: Position = Position.new()
var movement: Position = Position.new()


func _init(size: Vector2i = GameState.root_viewport.size) -> void:
	screen_size = size

func _to_string() -> String:
	return 'Boundaries(spawn=%s, movement=%s)' \
		% [spawn, movement]

func _set_screen_size(value: Vector2i) -> void:
	screen_size = value
	
	var base_position: Position = Position.new(
		Vector2.ZERO,
		screen_size,
		Direction4.from_float(Position.BASE_SAFETY_MARGIN)
	)
	
	spawn = base_position
	movement = base_position
	
	changed.emit()
