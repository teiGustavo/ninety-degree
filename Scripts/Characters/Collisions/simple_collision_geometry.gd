class_name SimpleCollisionGeometry
extends CollisionShape2D


var distances_from_middle: Bound2


func _ready() -> void:
	if shape is RectangleShape2D:
		distances_from_middle = Bound2.from_vector2(
			Vector2(shape.extents.x, shape.extents.y)
		)
	elif shape is CircleShape2D:
		distances_from_middle = Bound2.from_float(shape.radius)
	elif shape is CapsuleShape2D:
		push_error('CapsuleShape2D is not supported!')
	else:
		push_error('Shape is not defined!')
		
	if not distances_from_middle:
		distances_from_middle = Bound2.new()
