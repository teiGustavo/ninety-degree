class_name PositionBound2
extends Bound2


const BASE_SAFETY_MARGIN: float = 7.5
const BASE_VECTOR2_SAFETY_MARGIN: Vector2 = Vector2(
	BASE_SAFETY_MARGIN, 
	BASE_SAFETY_MARGIN
)

var safety_margin: Bound2 = Bound2.from_float(BASE_SAFETY_MARGIN):
	set = _set_safety_margin


func _init(
	this_minimum: Vector2 = Vector2.ZERO, 
	this_maximum: Vector2 = GameState.root_viewport.size,
	this_safety_margin: Bound2 = Bound2.from_float(BASE_SAFETY_MARGIN)
) -> void:
	super._init(
		this_minimum + this_safety_margin.minimum, 
		this_maximum - this_safety_margin.maximum
	)
	
	safety_margin = this_safety_margin
	
	safety_margin.minimum_changed.connect(_on_safety_margin_minimum_changed)
	safety_margin.maximum_changed.connect(_on_safety_margin_maximum_changed)

func _to_string() -> String:
	return 'PositionBound(minimum=%s, maximum=%s, safety_margin=%s)' \
		% [minimum, maximum, safety_margin]

func _on_safety_margin_minimum_changed(old: Vector2, new: Vector2):
	if new > old:
		minimum += new - old
	else:
		minimum -= old - new
	
func _on_safety_margin_maximum_changed(old: Vector2, new: Vector2):
	if new > old:
		maximum -= new - old 
	else:
		maximum += old - new 

func _set_safety_margin(value: Bound2):
	if safety_margin.maximum >= value.maximum \
		and safety_margin.maximum >= value.minimum:
		return

	safety_margin.minimum = value.minimum
	safety_margin.maximum = value.maximum
