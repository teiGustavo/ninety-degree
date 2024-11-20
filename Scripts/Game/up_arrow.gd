class_name UpArrow
extends Node2D


var screen_limits: ScreenLimits

var _size: Vector2

@onready var fade: Fade = Fade.new(self)
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	_size = Vector2(
		sprite_2d.texture.get_width(), 
		sprite_2d.texture.get_height()
	) * scale
	
	if not screen_limits:
		screen_limits = ScreenLimits.new(self, get_viewport().size)
	
	screen_limits.safety_margin.add(Direction4.from_vector2(_size / 2))
	
	clamp_position()
	fade_in()

func fade_in() -> void:
	fade.fade_in().opacity().set_duration(0.05) \
		.set_callback(fade_in).execute()

func clamp_position() -> void:
	position.x = clampf(position.x, screen_limits.get_min_x_position(), screen_limits.get_max_x_position())
	position.y = clampf(position.y, screen_limits.get_min_y_position(), screen_limits.get_max_y_position())
