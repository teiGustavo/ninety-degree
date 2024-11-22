class_name PolygonCollisionGeometry
extends CollisionPolygon2D


var distances_from_middle: Bound2


func _ready() -> void:
	if polygon:
		var bound2: Bound2 = Bound2.new(
			Vector2(INF, INF),
			Vector2(-INF, -INF)
		)
		
		for point in polygon:
			bound2.minimum.x = min(bound2.minimum.x, point.x)
			bound2.maximum.x = max(bound2.maximum.x, point.x)
			bound2.minimum.y = min(bound2.minimum.y, point.y)
			bound2.maximum.y = max(bound2.maximum.y, point.y)
			
		bound2.minimum = abs(bound2.minimum)
		bound2.maximum = abs(bound2.maximum)
		
		distances_from_middle = bound2
	else:
		push_error('Polygon is not defined!')
		
	if not distances_from_middle:
		distances_from_middle = Bound2.new()
