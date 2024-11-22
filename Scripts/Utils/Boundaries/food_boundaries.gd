class_name FoodBoundaries
extends Boundaries


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

@export var parent: Node2D

var corner_positions: Dictionary
var opposite_corner_positions: Dictionary


func _ready() -> void:
	if not parent:
		push_error('Parent is not defined!')
		return
		
	update_corner_positions()

func update_corner_positions() -> void:
	corner_positions = {
		Corner.TOP_LEFT: Vector2(movement.get_min_x(), movement.get_min_y()),
		Corner.TOP_RIGHT: Vector2(movement.get_max_x(), movement.get_min_y()),
		Corner.BOTTOM_LEFT: Vector2(movement.get_min_x(), movement.get_max_y()),
		Corner.BOTTOM_RIGHT: Vector2(movement.get_max_x(), movement.get_max_y()),
	}
	
	opposite_corner_positions = {
		Corner.TOP_LEFT: corner_positions[Corner.BOTTOM_RIGHT],
		Corner.TOP_RIGHT: corner_positions[Corner.BOTTOM_LEFT],
		Corner.BOTTOM_LEFT: corner_positions[Corner.TOP_RIGHT],
		Corner.BOTTOM_RIGHT: corner_positions[Corner.TOP_LEFT],
	}

func position_is_on_edge(edge: Edge) -> bool:
	match edge:
		Edge.TOP:
			return true if parent.position.y == movement.get_min_y() else false
		Edge.RIGHT:
			return true if parent.position.x == movement.get_max_x() else false
		Edge.BOTTOM:
			return true if parent.position.y == movement.get_max_y() else false
		Edge.LEFT:
			return true if parent.position.x == movement.get_min_x() else false
		_:
			return false

func position_is_on_corner(corner: Corner) -> bool:
	return true if corner_positions.find_key(parent.position) == corner \
		else false

func get_opposite_corner_position() -> Vector2:
	return opposite_corner_positions.get(
		corner_positions.find_key(parent.position)
	)
