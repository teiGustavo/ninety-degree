@tool
class_name BaseGame
extends Node2D


signal difficulty_changed
signal locked_difficulty_changed

@export_group("Difficulty")

var difficulty_detailments: Array[Difficultyy]:
	set = _set_difficulty_detailments
var lock_difficulty: bool = false:
	set = _set_lock_difficulty
var locked_difficulty: Difficultyy:
	set = _set_locked_difficulty
var current_difficulty: Difficultyy:
	set = _set_current_difficulty,
	get = _get_current_difficulty
var not_spawn_enemies: bool = false:
	set = _set_not_spawn_enemies


func _ready() -> void:
	update_difficulty()
	
func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	
	properties.append({
		"name": "lock_difficulty",
		"type": TYPE_BOOL,
		"usage": PROPERTY_USAGE_DEFAULT,
	})
	
	if lock_difficulty:
		properties.append({
			"name": "locked_difficulty",
			"type": TYPE_INT,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": ",".join(DifficultyManager.Difficulty.keys()),
		})
	
	properties.append({
		"name": "not_spawn_enemies",
		"type": TYPE_BOOL,
		"usage": PROPERTY_USAGE_DEFAULT,
	})
	
	return properties

func update_difficulty() -> void:
	for difficulty_detailment in difficulty_detailments:
		if GameState.score < difficulty_detailment.score_limit:
			current_difficulty = difficulty_detailment
			break

func _set_difficulty_detailments(value: Array[Difficultyy]) -> void:
	difficulty_detailments = value
	
	difficulty_detailments.sort_custom(
		func(a: Difficultyy, b: Difficultyy) -> bool: 
			return true if a.score_limit < b.score_limit else false
	)

func _set_lock_difficulty(value: bool) -> void:
	lock_difficulty = value
	notify_property_list_changed()
	locked_difficulty_changed.emit()
		
func _set_locked_difficulty(value: Difficultyy) -> void:
	locked_difficulty = value
	notify_property_list_changed()
	locked_difficulty_changed.emit()

func _set_current_difficulty(value: Difficultyy) -> void:
	current_difficulty = value
	difficulty_changed.emit()

func _get_current_difficulty() -> Difficultyy:
	return current_difficulty if not lock_difficulty else locked_difficulty

func _set_not_spawn_enemies(value: bool) -> void:
	not_spawn_enemies = value
	notify_property_list_changed()
