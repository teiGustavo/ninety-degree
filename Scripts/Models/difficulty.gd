@tool
class_name Difficultyy
extends Resource


@export var name: String
@export var food_movement_mode: Food.MovementMode
@export var speed_increase: float
@export var enemy_variations: Array[PackedScene]

var score_is_infinite: bool = false:
	set = _set_score_is_infinite
var score_limit: float = 0:
	set = _set_score_limit


func _to_string() -> String:
	return "Difficulty(name=%s, food_movement_mode=%s, score_limit=%d, speed_increase=%.2f, enemy_variations=%s)" % [
		name, 
		food_movement_mode, 
		score_limit, 
		speed_increase,
		"..."
	]

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	
	properties.append({
		"name": "score_is_infinite",
		"type": TYPE_BOOL,
		"usage": PROPERTY_USAGE_DEFAULT,
	})
	
	if not score_is_infinite:
		properties.append({
			"name": "score_limit",
			"type": TYPE_FLOAT,
			"usage": PROPERTY_USAGE_DEFAULT
		})
	
	return properties

func _set_score_is_infinite(value: bool) -> void:
	score_is_infinite = value
	score_limit = INF
	notify_property_list_changed()
	
func _set_score_limit(value: float) -> void:
	score_limit = value
	notify_property_list_changed()
	
