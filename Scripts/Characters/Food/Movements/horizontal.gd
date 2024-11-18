class_name HorizontalMovement
extends Movement


func set_food_direction() -> void:
	match food.direction:
		Vector2.RIGHT:
			if food.is_on_right_edge():
				food.direction = Vector2.LEFT
		Vector2.LEFT:
			if food.is_on_left_edge():
				food.direction = Vector2.RIGHT
		_:
			if food.is_on_left_edge():
				food.direction = Vector2.RIGHT
			elif food.is_on_right_edge():
				food.direction = Vector2.LEFT
			else:
				food.direction = food.get_min_x_direction()
