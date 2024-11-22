class_name PositionBound2
extends Bound2


const BASE_SAFETY_MARGIN: float = 7.5
const BASE_VECTOR2_SAFETY_MARGIN: Vector2 = Vector2(
	BASE_SAFETY_MARGIN, 
	BASE_SAFETY_MARGIN
)

var safety_margin: Bound2 = Bound2.from_float(BASE_SAFETY_MARGIN)


func _init(
	this_minimum: Vector2 = Vector2.ZERO, 
	this_maximum: Vector2 = GameState.root_viewport.size,
	this_safety_margin: Bound2 = Bound2.from_float(BASE_SAFETY_MARGIN)
) -> void:
	super._init(this_minimum, this_maximum)
	
	safety_margin = this_safety_margin

func _to_string() -> String:
	return 'PositionBound(min=%s, max=%s)' % [
			Vector2(get_min_x(), get_min_y()), 
			Vector2(get_max_x(), get_max_y())
		]

func get_min_x() -> float:
	return minimum.x + safety_margin.minimum.x

func get_min_y() -> float:
	return minimum.y + safety_margin.minimum.y

func get_max_x() -> float:
	return maximum.x - safety_margin.maximum.x
	
func get_max_y() -> float:
	return maximum.y - safety_margin.maximum.y

func get_random_x() -> float:
	return randf_range(get_min_x(), get_max_x())
	
func get_random_y() -> float:
	return randf_range(get_min_y(), get_max_y())
	
func get_random() -> Vector2:
	return Vector2(get_random_x(), get_random_y())
