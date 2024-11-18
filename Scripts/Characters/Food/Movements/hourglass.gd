class_name HourglassMovement
extends Movement


func set_food_direction() -> void:
	if food.is_on_some_corner() and food.is_moving_diagonally():
		HorizontalMovement.new(food).set_food_direction()
	else:
		LemniscateMovement.new(food).set_food_direction()
