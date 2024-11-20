class_name Direction4
extends Node


signal changed

@export var top: float = 0
@export var left: float = 0
@export var bottom: float = 0
@export var right: float = 0


static func from_float(number: float) -> Direction4:
	var instance: Direction4 = Direction4.new()
	
	instance.left = number
	instance.right = number
	instance.top = number
	instance.bottom = number
	
	return instance

static func from_vector2(vector2: Vector2) -> Direction4:
	var instance: Direction4 = Direction4.new()
	
	instance.left = vector2.x
	instance.right = vector2.x
	instance.top = vector2.y
	instance.bottom = vector2.y
	
	return instance
	
func add(direction4: Direction4) -> void:
	top += direction4.top
	left += direction4.left
	bottom += direction4.bottom
	right += direction4.right
	
	changed.emit()
	
func sub(direction4: Direction4) -> void:
	top -= direction4.top
	left -= direction4.left
	bottom -= direction4.bottom
	right -= direction4.right
	
	changed.emit()
	
func mul(direction4: Direction4) -> void:
	top *= direction4.top
	left *= direction4.left
	bottom *= direction4.bottom
	right *= direction4.right
	
	changed.emit()
	
func div(direction4: Direction4) -> void:
	top /= direction4.top
	left /= direction4.left
	bottom /= direction4.bottom
	right /= direction4.right
	
	changed.emit()
	
func to_dict() -> Dictionary:
	return {
		'top': top,
		'left': left,
		'bottom': bottom,
		'right': right,
	}
	
func to_array() -> Array[float]:
	return [top, left, bottom, right]
