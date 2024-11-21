class_name ScreenLimits
extends Node


enum Edge {
	TOP,
	RIGHT,
	BOTTOM,
	LEFT,
}
enum Corner {
	TOP_LEFT,
	TOP_RIGHT,
	BOTTOM_LEFT,
	BOTTOM_RIGHT,
}

@export var parent: Node

var screen_size: Vector2i
var screen_min_size: Vector2 = Vector2.ZERO
var safety_margin: Direction4 = Direction4.from_float(5):
	set = _set_safety_margin

var corner_positions: Dictionary = {
	Corner.TOP_LEFT: Vector2(get_min_x_position(), get_min_y_position()),
	Corner.TOP_RIGHT: Vector2(get_max_x_position(), get_min_y_position()),
	Corner.BOTTOM_LEFT: Vector2(get_min_x_position(), get_max_y_position()),
	Corner.BOTTOM_RIGHT: Vector2(get_max_x_position(), get_max_y_position()),
}
var opposite_corner_positions: Dictionary = {
	Corner.TOP_LEFT: corner_positions[Corner.BOTTOM_RIGHT],
	Corner.TOP_RIGHT: corner_positions[Corner.BOTTOM_LEFT],
	Corner.BOTTOM_LEFT: corner_positions[Corner.TOP_RIGHT],
	Corner.BOTTOM_RIGHT: corner_positions[Corner.TOP_LEFT],
}


func _init(this_parent: Node, size: Vector2i, min_size: Vector2 = Vector2.ZERO, margin: Direction4 = safety_margin) -> void:
	parent = this_parent
	screen_size = size
	screen_min_size = min_size
	safety_margin = margin
	
	safety_margin.changed.connect(update_corner_positions)
	
	update_corner_positions()

func update_corner_positions() -> void:
	corner_positions = {
		Corner.TOP_LEFT: Vector2(get_min_x_position(), get_min_y_position()),
		Corner.TOP_RIGHT: Vector2(get_max_x_position(), get_min_y_position()),
		Corner.BOTTOM_LEFT: Vector2(get_min_x_position(), get_max_y_position()),
		Corner.BOTTOM_RIGHT: Vector2(get_max_x_position(), get_max_y_position()),
	}
	
	opposite_corner_positions = {
		Corner.TOP_LEFT: corner_positions[Corner.BOTTOM_RIGHT],
		Corner.TOP_RIGHT: corner_positions[Corner.BOTTOM_LEFT],
		Corner.BOTTOM_LEFT: corner_positions[Corner.TOP_RIGHT],
		Corner.BOTTOM_RIGHT: corner_positions[Corner.TOP_LEFT],
	}
	
func get_min_size() -> Vector2i:
	return screen_min_size
	
func get_size() -> Vector2i:
	return screen_size

func get_min_x_position() -> float:
	return get_min_size().x + safety_margin.left

func get_min_y_position() -> float:
	return get_min_size().y + safety_margin.top

func get_max_x_position() -> float:
	return get_size().x - safety_margin.right
	
func get_max_y_position() -> float:
	return get_size().y - safety_margin.bottom

func get_random_x_position() -> float:
	return randf_range(get_min_x_position(), get_max_x_position())
	
func get_random_y_position() -> float:
	return randf_range(get_min_y_position(), get_max_y_position())

func get_random_position() -> Vector2:
	return Vector2(get_random_x_position(), get_random_y_position())

func position_is_on_edge(edge: Edge) -> bool:
	match edge:
		Edge.TOP:
			return true if parent.position.y == get_min_y_position() else false
		Edge.RIGHT:
			return true if parent.position.x == get_max_x_position() else false
		Edge.BOTTOM:
			return true if parent.position.y == get_max_y_position() else false
		Edge.LEFT:
			return true if parent.position.x == get_min_x_position() else false
		_:
			return false

func position_is_on_corner(corner: Corner) -> bool:
	return true if corner_positions.find_key(parent.position) == corner else false

func get_opposite_corner_position() -> Vector2:
	return opposite_corner_positions.get(corner_positions.find_key(parent.position))

func _set_safety_margin(value: Direction4) -> void:
	safety_margin = value
	update_corner_positions()
