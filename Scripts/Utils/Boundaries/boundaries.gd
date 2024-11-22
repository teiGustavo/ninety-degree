class_name Boundaries
extends Node


@export var parent: Node2D:
	set = _set_parent

var screen_size: Vector2i
var spawn: Position = Position.new()
var movement: MovementPosition = MovementPosition.new()


func _ready() -> void:
	if not parent:
		push_error('Parent is not defined!')
		return
		
	screen_size = get_viewport().size

func _to_string() -> String:
	return 'Boundaries(spawn=%s, movement=%s)' \
		% [spawn, movement]

func _set_parent(value: Node2D) -> void:
	parent = value
	parent.ready.connect(_on_parent_ready)
	
func _set_screen_size(value: Vector2i) -> void:
	screen_size = value
	
	spawn = Position.new(
		Direction4.from_float(0),
		Direction4.from_vector2(screen_size)
	)
	movement = MovementPosition.new(
		Direction4.from_float(0),
		Direction4.from_vector2(screen_size),
		Direction4.from_float(5)
	)

func _on_parent_ready() -> void:
	screen_size = parent.get_viewport().size
	
	parent.get_viewport().size_changed.connect(
		func() -> void: screen_size = parent.get_viewport().size
	)
	
