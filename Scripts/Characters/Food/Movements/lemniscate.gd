class_name LemniscateMovement
extends Movement


func set_food_direction() -> void:
	if is_on_some_corner():
		if is_moving_diagonally():
			VerticalMovement.new(food).set_food_direction()
		else:
			food.direction = food.position.direction_to(
				get_opposite_corner_position()
			)
	elif not is_moving_diagonally():
		AroundEdgesMovement.new(food).set_food_direction()
