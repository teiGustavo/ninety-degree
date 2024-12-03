class_name BaseCharacter
extends CharacterBody2D


signal collided(collider: Object)
signal scale_changed

@export_custom(
	PROPERTY_HINT_NODE_TYPE, 
	"SimpleCollisionGeometry,PolygonCollisionGeometry"
) var collision_geometry: Node2D

static var auto_destroy_position: Bound2 = Bound2.new(
	-GameState.root_viewport.size * 2,
	GameState.root_viewport.size * 2,
)

var boundaries: Boundaries = Boundaries.new()
var speed: float
var direction: Vector2

@onready var fade: Fade = Fade.new(self)

@onready var _last_scale: Vector2 = scale


func _ready() -> void:
	collided.connect(_on_collided)
	scale_changed.connect(_update_safety_margin)
	
	if not collision_geometry:
		push_error('CollisionGeometry is not defined!')
	elif collision_geometry is not SimpleCollisionGeometry \
		and collision_geometry is not PolygonCollisionGeometry:
		push_error('CollisionGeometry type is invalid!')
	
	_update_safety_margin()
	
func _notification(what: int):
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		
		if scale != _last_scale:
			_last_scale = scale
			scale_changed.emit()

func move_based_on_velocity() -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity)
	
	if collision:
		collided.emit(collision.get_collider())
		
	clamp_position()
	
	if position.x < auto_destroy_position.minimum.x \
		or position.x > auto_destroy_position.maximum.x \
		or position.y < auto_destroy_position.minimum.y \
		or position.y > auto_destroy_position.maximum.y:
		queue_free()
		
func speed_is_empty() -> bool:
	return true if not speed or speed == 0 else false

func get_min_x_direction() -> Vector2:
	if position.x - boundaries.movement.minimum.x \
		> boundaries.movement.maximum.x - position.x:
		return Vector2.RIGHT

	return Vector2.LEFT
	
func get_min_y_direction() -> Vector2:
	if position.y - boundaries.movement.minimum.y \
		> boundaries.movement.maximum.y - position.y:
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
	position = position.clamp(
		boundaries.movement.minimum,
		boundaries.movement.maximum
	)

func fade_queue_free(
	duration: float = 1, 
	callback: Callable = Callable(),
	disable_collision: bool = true
) -> void:
	speed = 0
	
	if disable_collision:
		collision_geometry.disabled = true
	
	fade.fade_out().scale().set_duration(duration).set_callback(callback) \
		.set_callback(queue_free).execute()
	fade.fade_out().opacity().set_duration(duration).set_callback(callback) \
		.set_callback(queue_free).execute()

func _update_safety_margin() -> void:
	var scaled_minimum: Vector2 = \
		collision_geometry.distances_from_middle.minimum * scale
		
	var scaled_maximum: Vector2 = \
		collision_geometry.distances_from_middle.maximum * scale
	
	scaled_minimum += PositionBound2.BASE_VECTOR2_SAFETY_MARGIN
	scaled_maximum += PositionBound2.BASE_VECTOR2_SAFETY_MARGIN
	
	boundaries.spawn.safety_margin.minimum = scaled_minimum
	boundaries.spawn.safety_margin.maximum = scaled_maximum
	
	boundaries.movement.safety_margin.minimum = scaled_minimum
	boundaries.movement.safety_margin.maximum = scaled_maximum

func _on_collided(_collider: Object) -> void:
	pass
	
