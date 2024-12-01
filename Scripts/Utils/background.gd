@tool
class_name Backgorund
extends Control


@export_range(0, 1, 0.1) var opacity: float = 1:
	set = _set_opacity

@onready var color_rect: ColorRect = $ColorRect


func _set_opacity(value: float):
	opacity = clampf(value, 0, 1)
	
	if color_rect:
		color_rect.modulate.a = opacity
		
	notify_property_list_changed()
