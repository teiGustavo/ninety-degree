class_name DifficultyManager
extends Node


enum Difficulty {
	VERY_EASY,
	EASY,
	MEDIUM,
	HARD,
	VERY_HARD,
	EXTREME,
}

const JSON_FILE_PATH: String = "res://Data/difficulty_detailment.json"

var difficulty_detailments: Dictionary

static var _enemy_scenes: Dictionary = {
	Enemy.Variation.SQUARE: preload("res://Prefabs/Characters/Enemy/enemy_square.tscn"),
	Enemy.Variation.VERTICAL_RECTANGLE: preload("res://Prefabs/Characters/Enemy/enemy_vertical_rectangle.tscn"),
	Enemy.Variation.HORIZONTAL_RECTANGLE: preload("res://Prefabs/Characters/Enemy/enemy_horizontal_rectangle.tscn"),
}
var _difficulty_rules: Dictionary


func _init(game_id: String) -> void:
	_update_difficulty_rules(game_id)
	_update_difficulty_detailments()

func get_difficulty_detailment(difficulty: Difficulty) -> DifficultyDetailment:
	return difficulty_detailments[difficulty]

func _update_difficulty_rules(game_id: String) -> void:
	var all_rules: Dictionary = DataManager.get_from_json(JSON_FILE_PATH)
	
	var game_difficulty_rules: Variant = all_rules.get(game_id.to_lower())
	
	if not game_difficulty_rules:
		push_error("Game ID not exists, default has been selected!")
		
		_difficulty_rules = all_rules["default"]
		return
	
	_difficulty_rules = game_difficulty_rules
	
func _update_difficulty_detailments() -> void:
	for difficulty_rule in _difficulty_rules:
		var difficulty: Difficulty = Difficulty.get(difficulty_rule.to_upper())
		var food_movement: Food.MovementMode = Food.MovementMode.get(
			_difficulty_rules[difficulty_rule]["food_movement"].to_upper()
		)
		var score_limit: Variant = _difficulty_rules[difficulty_rule]["score_limit"]
		var speed_increase: float = \
			_difficulty_rules[difficulty_rule]["speed_increase"]
		var enemy_variations: Array[String] = Array(
			Array(_difficulty_rules[difficulty_rule]["enemy_variations"]),
			TYPE_STRING, "", null
		)
		
		var detailment: DifficultyDetailment = DifficultyDetailment.new() \
			.set_food_movement_mode(food_movement) \
			.set_score_limit(score_limit) \
			.set_speed_increase(speed_increase)
			
		for enemy_variation in enemy_variations:
			detailment.add_enemy_variation(
				_enemy_scenes[Enemy.Variation.get(enemy_variation.to_upper())]
			)
		
		difficulty_detailments[difficulty] = detailment
