class_name AroundEdgesMovement
extends Movement


func horizontal_movement() -> void:
	HorizontalMovement.new(food).set_food_direction()
	
func vertical_movement() -> void:
	VerticalMovement.new(food).set_food_direction()

func set_food_direction() -> void:
	if is_on_some_corner():
		if food.direction in [Vector2.UP, Vector2.DOWN]:
			horizontal_movement()
		else:
			vertical_movement()
	elif is_on_some_edge():
		if is_on_some_horizontal_edge():
			vertical_movement()
		else:
			horizontal_movement()
	else:
		horizontal_movement()
