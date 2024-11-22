class_name Position
extends Node


const BASE_SAFETY_MARGIN: float = 5

var safety_margin: Direction4 = Direction4.from_float(BASE_SAFETY_MARGIN)

var _min: Vector2
var _max: Vector2


func _init(
	this_min: Vector2 = Vector2.ZERO, 
	this_max: Vector2 = GameState.root_viewport.size,
	this_safety_margin: Direction4 = Direction4.from_float(BASE_SAFETY_MARGIN)
) -> void:
	_min = this_min
	_max = this_max
	safety_margin = this_safety_margin

func _to_string() -> String:
	return 'Position(min=%s, max=%s)' % [
			Vector2(get_min_x(), get_min_y()), 
			Vector2(get_max_x(), get_max_y())
		]

func get_min_x() -> float:
	return _min.x + safety_margin.left

func get_min_y() -> float:
	return _min.y + safety_margin.top

func get_max_x() -> float:
	return _max.x - safety_margin.right
	
func get_max_y() -> float:
	return _max.y - safety_margin.bottom

func get_random_x() -> float:
	return randf_range(get_min_x(), get_max_x())
	
func get_random_y() -> float:
	return randf_range(get_min_y(), get_max_y())
	
func get_random() -> Vector2:
	return Vector2(get_random_x(), get_random_y())
