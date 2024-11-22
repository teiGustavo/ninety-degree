class_name HourglassMovement
extends Movement


func set_food_direction() -> void:
	if is_on_some_corner() and is_moving_diagonally():
		HorizontalMovement.new(food).set_food_direction()
	else:
		LemniscateMovement.new(food).set_food_direction()
