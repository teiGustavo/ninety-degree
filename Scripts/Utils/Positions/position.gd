class_name Position
extends Node


var min: Direction4
var max: Direction4


func _init(
	this_min: Direction4 = Direction4.new(), 
	this_max: Direction4 = Direction4.new()
) -> void:
	min = this_min
	max = this_max

func _to_string() -> String:
	return 'Position(min=%s, max=%s)' % [min, max]

func get_min_x() -> float:
	return min.left

func get_min_y() -> float:
	return min.top

func get_max_x() -> float:
	return max.right
	
func get_max_y() -> float:
	return max.bottom

func get_random_x() -> float:
	return randf_range(get_min_x(), get_max_x())
	
func get_random_y() -> float:
	return randf_range(get_min_y(), get_max_y())
	
func get_random() -> Vector2:
	return Vector2(get_random_x(), get_random_y())
