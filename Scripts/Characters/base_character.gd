class_name BaseCharacter
extends CharacterBody2D


signal collided(collider: Object)

var screen_limits: ScreenLimits
var speed: float
var direction: Vector2
var collision_shape: CollisionShape2D

@onready var fade: Fade = Fade.new(self)


func _ready() -> void:
	collided.connect(_on_collided)
	
	if not screen_limits:
		screen_limits = ScreenLimits.new(self, get_viewport().size)

func move_based_on_velocity() -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity)
	
	if collision:
		collided.emit(collision.get_collider())
		
	clamp_position()
		
func speed_is_empty() -> bool:
	return true if not speed or speed == 0 else false

func get_min_x_direction() -> Vector2:
	if position.x - screen_limits.get_min_x_position() > screen_limits.get_max_x_position() - position.x:
		return Vector2.RIGHT

	return Vector2.LEFT
	
func get_min_y_direction() -> Vector2:
	if position.y - screen_limits.get_min_y_position() > screen_limits.get_max_y_position() - position.y:
		return Vector2.DOWN
	
	return Vector2.UP

func is_moving() -> bool:
	return true if direction != Vector2.ZERO else false
	
func is_moving_diagonally() -> bool:
	return true if direction not in [Vector2.ZERO, Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT] else false

func is_on_top_edge() -> bool:
	return true if screen_limits.position_is_on_edge(ScreenLimits.Edge.TOP) else false
	
func is_on_bottom_edge() -> bool:
	return true if screen_limits.position_is_on_edge(ScreenLimits.Edge.BOTTOM) else false

func is_on_left_edge() -> bool:
	return true if screen_limits.position_is_on_edge(ScreenLimits.Edge.LEFT) else false
	
func is_on_right_edge() -> bool:
	return true if screen_limits.position_is_on_edge(ScreenLimits.Edge.RIGHT) else false

func is_on_some_vertical_edge() -> bool:
	return true if is_on_top_edge() or is_on_bottom_edge() else false

func is_on_some_horizontal_edge() -> bool:
	return true if is_on_left_edge() or is_on_right_edge() else false
	
func is_on_some_edge() -> bool:
	return true if is_on_some_vertical_edge() or is_on_some_horizontal_edge() else false

func is_on_some_corner() -> bool:
	return true if is_on_some_vertical_edge() and is_on_some_horizontal_edge() else false

func clamp_position() -> void:
	position.x = clampf(position.x, screen_limits.get_min_x_position(), screen_limits.get_max_x_position())
	position.y = clampf(position.y, screen_limits.get_min_y_position(), screen_limits.get_max_y_position())

func fade_queue_free(duration: float = 1, callback: Callable = Callable()) -> void:
	speed = 0
	
	if collision_shape:
		collision_shape.disabled = true
		
	fade.fade_out().scale().set_duration(duration).set_callback(callback) \
		.set_callback(queue_free).execute()
	fade.fade_out().opacity().set_duration(duration).set_callback(callback) \
		.set_callback(queue_free).execute()

func _on_collided(_collider: Object) -> void:
	pass
	
