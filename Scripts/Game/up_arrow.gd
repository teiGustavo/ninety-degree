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
	
	boundaries.spawn.safety_margin.add(Direction4.from_vector2(_size / 2))
	
	clamp_position()
	fade_in()

func fade_in() -> void:
	fade.fade_in().opacity().set_duration(0.05) \
		.set_callback(fade_in).execute()

func clamp_position() -> void:
	position.x = clampf(
		position.x, 
		boundaries.spawn.get_min_x(), 
		boundaries.spawn.get_max_x()
	)
	
	position.y = clampf(
		position.y, 
		boundaries.spawn.get_min_y(), 
		boundaries.spawn.get_max_y()
	)
