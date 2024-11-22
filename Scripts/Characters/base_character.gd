class_name BaseCharacter
extends CharacterBody2D


signal collided(collider: Object)

@export_custom(
	PROPERTY_HINT_NODE_TYPE, 
	"SimpleCollisionGeometry,PolygonCollisionGeometry"
) var collision_geometry: Node2D

var boundaries: Boundaries = Boundaries.new()
var speed: float
var direction: Vector2

@onready var fade: Fade = Fade.new(self)


func _ready() -> void:
	collided.connect(_on_collided)
	
	if not collision_geometry:
		push_error('CollisionGeometry is not defined!')
	elif collision_geometry is not SimpleCollisionGeometry \
		and collision_geometry is not PolygonCollisionGeometry:
		push_error('CollisionGeometry type is invalid!')
	
	var scaled_distances_from_middle: Direction4 = Direction4.from_distance4(
		collision_geometry.distances_from_middle
	)
	
	scaled_distances_from_middle.mul(Direction4.from_vector2(scale))

	boundaries.spawn.safety_margin = Direction4.from_float(
		Position.BASE_SAFETY_MARGIN
	)
	boundaries.spawn.safety_margin.add(scaled_distances_from_middle)
	
	boundaries.movement.safety_margin = Direction4.from_float(
		Position.BASE_SAFETY_MARGIN
	)
	boundaries.movement.safety_margin.add(scaled_distances_from_middle)

func move_based_on_velocity() -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity)
	
	if collision:
		collided.emit(collision.get_collider())
		
	clamp_position()
		
func speed_is_empty() -> bool:
	return true if not speed or speed == 0 else false

func get_min_x_direction() -> Vector2:
	if position.x - boundaries.movement.get_min_x() \
		> boundaries.movement.get_max_x() - position.x:
		return Vector2.RIGHT

	return Vector2.LEFT
	
func get_min_y_direction() -> Vector2:
	if position.y - boundaries.movement.get_min_y() \
		> boundaries.movement.get_max_y() - position.y:
		return Vector2.DOWN
	
	return Vector2.UP

func is_moving() -> bool:
	return true if direction != Vector2.ZERO else false
	
func is_moving_diagonally() -> bool:
	return true if direction not in [
			Vector2.ZERO, Vector2.UP, Vector2.RIGHT, 
			Vector2.DOWN, Vector2.LEFT
		] else false

func clamp_position() -> void:
	position.x = clampf(
		position.x, 
		boundaries.movement.get_min_x(), 
		boundaries.movement.get_max_x()
	)
	
	position.y = clampf(
		position.y, 
		boundaries.movement.get_min_y(), 
		boundaries.movement.get_max_y()
	)

func fade_queue_free(
	duration: float = 1, 
	callback: Callable = Callable()
) -> void:
	speed = 0
	
	collision_geometry.disabled = true
		
	fade.fade_out().scale().set_duration(duration).set_callback(callback) \
		.set_callback(queue_free).execute()
	fade.fade_out().opacity().set_duration(duration).set_callback(callback) \
		.set_callback(queue_free).execute()

func _on_collided(_collider: Object) -> void:
	pass
	
