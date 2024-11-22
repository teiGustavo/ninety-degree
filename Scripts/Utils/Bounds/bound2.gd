class_name Bound2
extends Node


signal changed

var minimum: Vector2:
	set = _set_minimum
var maximum: Vector2:
	set = _set_maximum


func _init(
	this_minimum: Vector2 = Vector2.ZERO, 
	this_maximum: Vector2 = Vector2.ZERO,
) -> void:
	minimum = this_minimum
	maximum = this_maximum

func _to_string() -> String:
	return 'Bound2(minimum=%s, maximum=%s)' % [minimum, maximum]

static func from_float(value: float) -> Bound2:
	var instance: Bound2 = Bound2.new()
	
	instance.minimum = Vector2(value, value)
	instance.maximum = Vector2(value, value)
	
	return instance
	
static func from_vector2(value: Vector2) -> Bound2:
	var instance: Bound2 = Bound2.new()
	
	instance.minimum = Vector2(value.x, value.y)
	instance.maximum = Vector2(value.x, value.y)
	
	return instance
	
static func from_bound2(value: Bound2) -> Bound2:
	var instance: Bound2 = Bound2.new()
	
	instance.minimum = value.minimum
	instance.maximum = value.maximum
	
	return instance

func _set_minimum(value: Vector2) -> void:
	minimum = value
	changed.emit()
	
func _set_maximum(value: Vector2) -> void:
	maximum = value
	changed.emit()
