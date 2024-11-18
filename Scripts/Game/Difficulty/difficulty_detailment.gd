class_name DifficultyDetailment
extends Node


var score_limit: float = float('inf')
var food_movement_mode: Food.MovementMode = Food.MovementMode.IDLE
var speed_increase: float = 0
var enemy_variations: Array[PackedScene] = []

func set_food_movement_mode(value: Food.MovementMode) -> DifficultyDetailment:
	food_movement_mode = value
	
	return self

func set_score_limit(value: Variant) -> DifficultyDetailment:
	score_limit = value if value and value > 0 else INF
	
	return self
	
func set_speed_increase(value: float) -> DifficultyDetailment:
	speed_increase = value
	
	return self

func set_enemy_variations(value: Array[PackedScene]) -> DifficultyDetailment:
	enemy_variations = value
	
	return self

func add_enemy_variation(value: PackedScene) -> DifficultyDetailment:
	enemy_variations.append(value)
	
	return self
