class_name BasePowerUp
extends Area2D


signal collected
signal scale_changed

const FADE_DURATION: float = 0.7

@export var collision_geometry: SimpleCollisionGeometry

var fade: Fade = Fade.new(self)
var boundaries: Boundaries = Boundaries.new()
var player: Player

var _last_scale: Vector2 = Vector2.ZERO

@onready var life_time_timer: Timer = $LifeTimeTimer
@onready var duration_timer: Timer = $DurationTimer
@onready var duration_left: TimeLeft = $DurationLeft


func _ready() -> void:
	if not collision_geometry:
		push_error('CollisionGeometry is not defined!')
		
	fade.fade_in().scale().from(0).set_duration(FADE_DURATION).execute()
		
	life_time_timer.timeout.connect(fade_queue_free)
	duration_timer.timeout.connect(fade_queue_free)
	duration_timer.timeout.connect(on_expired)
	
	body_entered.connect(_on_body_entered)
	collected.connect(on_collected)
	
	scale_changed.connect(_update_safety_margin)
	
	_update_safety_margin()

func _process(_delta: float) -> void:
	_update_duration_left()
	clamp_position()

func _notification(what: int):
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		
		if scale != _last_scale:
			_last_scale = scale
			scale_changed.emit()

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

func fade_out(duration: float = 1, 
	callbacks: Array[Callable] = [],
	disable_collision: bool = true
) -> void:
	if disable_collision:
		collision_geometry.disabled = true
	
	fade.fade_out().scale().set_duration(duration).set_callback(callbacks) \
		.execute()
	fade.fade_out().opacity().set_duration(duration).set_callback(callbacks) \
		.execute()

func fade_queue_free(
	duration: float = 1, 
	callback: Callable = Callable(),
	disable_collision: bool = true
) -> void:
	fade_out(duration, [callback, queue_free], disable_collision)

func on_collected() -> void:
	pass
	
func on_expired() -> void:
	pass

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

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		duration_left.visible = true
		collected.emit()
		duration_timer.start()
		life_time_timer.stop()
		call_deferred("fade_out")

func _update_duration_left() -> void:
	duration_left.seconds = ceili(duration_timer.time_left)
