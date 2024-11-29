class_name BasePowerUp
extends Node


const FADE_DURATION: float = 0.2

@export var collision_geometry: SimpleCollisionGeometry

var fade: Fade = Fade.new(self)
var boundaries: Boundaries = Boundaries.new()
var lifetime_in_seconds: float = 5

@onready var queue_free_timer: Timer = $QueueFreeTimer


func _ready() -> void:
	if not collision_geometry:
		push_error('CollisionGeometry is not defined!')
		
	fade.fade_in().scale().from(0.4).set_duration(FADE_DURATION).execute()
		
	queue_free_timer.wait_time = lifetime_in_seconds
	queue_free_timer.timeout.connect(fade_queue_free)
	
func fade_queue_free(
	duration: float = 1, 
	callback: Callable = Callable(),
	disable_collision: bool = true
) -> void:
	if disable_collision:
		collision_geometry.disabled = true
	
	fade.fade_out().scale().set_duration(duration).set_callback(callback) \
		.set_callback(queue_free).execute()
	fade.fade_out().opacity().set_duration(duration).set_callback(callback) \
		.set_callback(queue_free).execute()

func _update_safety_margin() -> void:
	var minimum: Vector2 = \
		collision_geometry.distances_from_middle.minimum + \
		PositionBound2.BASE_VECTOR2_SAFETY_MARGIN
		
	var maximum: Vector2 = \
		collision_geometry.distances_from_middle.maximum + \
		PositionBound2.BASE_VECTOR2_SAFETY_MARGIN
	
	boundaries.spawn.safety_margin.minimum = minimum
	boundaries.spawn.safety_margin.maximum = maximum
	
	boundaries.movement.safety_margin.minimum = minimum
	boundaries.movement.safety_margin.maximum = maximum
