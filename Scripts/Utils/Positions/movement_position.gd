class_name MovementPosition
extends Position


const BASE_SAFETY_MARGIN: float = 5

var safety_margin: Direction4 = Direction4.new()


func _init(
	this_min: Direction4 = Direction4.new(), 
	this_max: Direction4 = Direction4.new(),
	this_safety_margin: Direction4 = Direction4.from_float(BASE_SAFETY_MARGIN)
) -> void:
	super._init(this_min, this_max)
	
	safety_margin = this_safety_margin

func get_min_x() -> float:
	return min.left + safety_margin.left

func get_min_y() -> float:
	return min.top + safety_margin.top

func get_max_x() -> float:
	return max.right - safety_margin.right
	
func get_max_y() -> float:
	return max.bottom - safety_margin.bottom
