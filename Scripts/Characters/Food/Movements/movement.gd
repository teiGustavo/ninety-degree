class_name Movement
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

var food: Food
var corner_positions: Dictionary
var opposite_corner_positions: Dictionary


func _init(parent_food: Food) -> void:
	food = parent_food
	
	food.boundaries.changed.connect(update_corner_positions)
	food.boundaries.movement.changed.connect(update_corner_positions)
	
	update_corner_positions()

func update_corner_positions() -> void:
	corner_positions = {
		Corner.TOP_LEFT: Vector2(
			food.boundaries.movement.minimum.x,
			food.boundaries.movement.minimum.y
		),
		Corner.TOP_RIGHT: Vector2(
			food.boundaries.movement.maximum.x, 
			food.boundaries.movement.minimum.y
		),
		Corner.BOTTOM_LEFT: Vector2(
			food.boundaries.movement.minimum.x, 
			food.boundaries.movement.maximum.y
		),
		Corner.BOTTOM_RIGHT: Vector2(
			food.boundaries.movement.maximum.x, 
			food.boundaries.movement.maximum.y
		),
	}
	
	opposite_corner_positions = {
		Corner.TOP_LEFT: corner_positions[Corner.BOTTOM_RIGHT],
		Corner.TOP_RIGHT: corner_positions[Corner.BOTTOM_LEFT],
		Corner.BOTTOM_LEFT: corner_positions[Corner.TOP_RIGHT],
		Corner.BOTTOM_RIGHT: corner_positions[Corner.TOP_LEFT],
	}

func is_moving() -> bool:
	return food.is_moving()

func is_moving_diagonally() -> bool:
	return food.is_moving_diagonally()

func position_is_on_edge(edge: Edge) -> bool:
	match edge:
		Edge.TOP:
			return true if food.position.y == \
				food.boundaries.movement.minimum.y else false
		Edge.RIGHT:
			return true if food.position.x == \
				food.boundaries.movement.maximum.x else false
		Edge.BOTTOM:
			return true if food.position.y == \
				food.boundaries.movement.maximum.y else false
		Edge.LEFT:
			return true if food.position.x == \
				food.boundaries.movement.minimum.x else false
		_:
			return false

func position_is_on_corner(corner: Corner) -> bool:
	return true if corner_positions.find_key(food.position) == corner \
		else false

func get_opposite_corner_position() -> Vector2:
	return opposite_corner_positions.get(
		corner_positions.find_key(food.position)
	)

func is_on_top_edge() -> bool:
	return true if position_is_on_edge(Edge.TOP) else false
	
func is_on_bottom_edge() -> bool:
	return true if position_is_on_edge(Edge.BOTTOM) else false

func is_on_left_edge() -> bool:
	return true if position_is_on_edge(Edge.LEFT) else false
	
func is_on_right_edge() -> bool:
	return true if position_is_on_edge(Edge.RIGHT) else false

func is_on_some_vertical_edge() -> bool:
	return true if is_on_top_edge() or is_on_bottom_edge() else false

func is_on_some_horizontal_edge() -> bool:
	return true if is_on_left_edge() or is_on_right_edge() else false
	
func is_on_some_edge() -> bool:
	return true if is_on_some_vertical_edge() or is_on_some_horizontal_edge() \
		else false

func is_on_some_corner() -> bool:
	return true if is_on_some_vertical_edge() and is_on_some_horizontal_edge() \
		else false

func set_food_direction() -> void:
	assert(false)
