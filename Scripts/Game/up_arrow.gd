class_name UpArrow
extends Node2D


var boundaries: Boundaries = Boundaries.new()

var _size: Vector2

@onready var fade: Fade = Fade.new(self)
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	_size = Vector2(
		sprite_2d.texture.get_width(), 
		sprite_2d.texture.get_height()
	) * scale
	
	update_safety_margin()
	clamp_position()
	fade_in()

func update_safety_margin() -> void:
	boundaries.spawn.safety_margin.minimum = \
		PositionBound2.BASE_VECTOR2_SAFETY_MARGIN
	boundaries.spawn.safety_margin.maximum = \
		PositionBound2.BASE_VECTOR2_SAFETY_MARGIN
	
	boundaries.spawn.safety_margin.minimum += _size / 2
	boundaries.spawn.safety_margin.maximum += _size / 2

func fade_in() -> void:
	fade.fade_in().opacity().set_duration(0.05).set_callback(fade_in).execute()

func clamp_position() -> void:
	position.x = clampf(
		position.x, 
		boundaries.spawn.minimum.x, 
		boundaries.spawn.maximum.x
	)
	
	position.y = clampf(
		position.y, 
		boundaries.spawn.minimum.y, 
		boundaries.spawn.maximum.y
	)
