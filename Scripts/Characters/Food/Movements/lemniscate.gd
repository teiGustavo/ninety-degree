class_name LemniscateMovement
extends Movement


func set_food_direction() -> void:
	if food.is_on_some_corner():
		if food.is_moving_diagonally():
			VerticalMovement.new(food).set_food_direction()
		else:
			food.direction = food.position.direction_to(food.screen_limits.get_opposite_corner_position())
	elif not food.is_moving_diagonally():
		AroundEdgesMovement.new(food).set_food_direction()
