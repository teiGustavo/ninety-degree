class_name VerticalMovement
extends Movement


func set_food_direction() -> void:
	match food.direction:
		Vector2.UP:
			if is_on_top_edge():
				food.direction = Vector2.DOWN
		Vector2.DOWN:
			if is_on_bottom_edge():
				food.direction = Vector2.UP
		_:
			if is_on_top_edge():
				food.direction = Vector2.DOWN
			elif is_on_bottom_edge():
				food.direction = Vector2.UP
			else:
				food.direction = food.get_min_y_direction()
