@tool
class_name BaseGame
extends Node2D


signal difficulty_changed
signal locked_difficulty_changed
signal spawn_random_powerup

@export_group("Power Ups")
@export var all_power_ups: ResourceGroup = load(
	"res://Data/PowerUps/default_power_ups.tres"
)
@export var spawn_random_power_up: bool = false:
	set = _set_spawn_random_power_up
@export var not_spawn_power_ups: bool = false
@export_group("Difficulty")
@export var all_difficulties: ResourceGroup = load(
	"res://Data/Difficulties/default_difficulties.tres"
)

var difficulties: Array[Difficulty]:
	set = _set_difficulties
var lock_difficulty: bool = false:
	set = _set_lock_difficulty
var locked_difficulty: Difficulty:
	set = _set_locked_difficulty
var current_difficulty: Difficulty:
	set = _set_current_difficulty,
	get = _get_current_difficulty
var not_spawn_enemies: bool = false:
	set = _set_not_spawn_enemies
var power_ups: Array[PowerUp]

func _ready() -> void:
	if not all_difficulties:
		push_error("Please enter the difficulties ResourceGroup manually!")
		
	if not all_power_ups:
		push_error("Please enter the power ups ResourceGroup manually!")
	
	if all_difficulties:
		difficulties = Array(
			all_difficulties.load_all(),
			TYPE_OBJECT,
			"Resource",
			Difficulty
		)
		
	if all_power_ups:
		power_ups = Array(
			all_power_ups.load_all(),
			TYPE_OBJECT,
			"Resource",
			PowerUp
		)
	
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
			"type": TYPE_OBJECT,
			"usage": PROPERTY_USAGE_DEFAULT,
			"hint": PROPERTY_HINT_RESOURCE_TYPE,
			"hint_string": "Difficulty",
		})
	
	properties.append({
		"name": "not_spawn_enemies",
		"type": TYPE_BOOL,
		"usage": PROPERTY_USAGE_DEFAULT,
	})
	
	return properties

func update_difficulty() -> void:
	for difficulty_detailment in difficulties:
		if GameState.score < difficulty_detailment.score_limit:
			current_difficulty = difficulty_detailment
			break

func _set_difficulties(value: Array[Difficulty]) -> void:
	difficulties = value
	
	difficulties.sort_custom(
		func(a: Difficulty, b: Difficulty) -> bool: 
			return true if a.score_limit < b.score_limit else false
	)

func _set_lock_difficulty(value: bool) -> void:
	lock_difficulty = value
	locked_difficulty_changed.emit()
	notify_property_list_changed()
	
func _set_locked_difficulty(value: Difficulty) -> void:
	locked_difficulty = value
	locked_difficulty_changed.emit()
	notify_property_list_changed()

func _set_current_difficulty(value: Difficulty) -> void:
	current_difficulty = value
	difficulty_changed.emit()

func _get_current_difficulty() -> Difficulty:
	if lock_difficulty and locked_difficulty:
		return locked_difficulty
	
	return current_difficulty

func _set_not_spawn_enemies(value: bool) -> void:
	not_spawn_enemies = value
	notify_property_list_changed()

func _set_spawn_random_power_up(value: bool) -> void:
	spawn_random_power_up = false
	
	if value == true:
		spawn_random_powerup.emit()
