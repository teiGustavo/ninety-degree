class_name Fade
extends Node


enum Type {
	IN,
	OUT
}
enum Variation {
	SCALE,
	OPACITY
}

@export var parent: Node

var _fade_type: Type
var _fade_variation: Variation
var _val_unit: StringName
var _initial_val: Variant:
	set = _set_initial_val
var _final_val: Variant:
	set = _set_final_val
var _property: NodePath
var _duration: float
var _callbacks: Array[Callable]


func _init(this_parent: Node) -> void:
	parent = this_parent

func get_instance(this_parent: Node) -> Fade:
	return Fade.new(this_parent)

func fade(type: Type, variation: Variant = null) -> Fade:
	_fade_type = type
		
	match variation:
		Variation.SCALE:
			scale()
		Variation.OPACITY:
			opacity()
		
	_duration = 0.3
	_callbacks = []
	
	return self

func fade_in(variation: Variant = null) -> Fade:
	if variation:
		fade(Type.IN, variation)
	else:
		fade(Type.IN, Variation.OPACITY)
	
	return self
	
func fade_out(variation: Variant = null) -> Fade:
	if variation:
		fade(Type.OUT, variation)
	else:
		fade(Type.OUT, Variation.OPACITY)
	
	return self

func scale() -> Fade:
	_fade_variation = Variation.SCALE
	_val_unit = "Vector2"
	
	match _fade_type:
		Type.IN:
			_initial_val = Vector2.ZERO
			_final_val = parent.scale
		Type.OUT:
			_initial_val = parent.scale
			_final_val = Vector2.ZERO
	
	_property = "scale"
	
	return self
	
func opacity() -> Fade:
	_fade_variation = Variation.OPACITY
	_val_unit = "float"
	
	match _fade_type:
		Type.IN:
			_initial_val = 0
			_final_val = parent.modulate.a
		Type.OUT:
			_initial_val = parent.modulate.a
			_final_val = 0
			
	_property = "modulate:a"
	
	return self
	
func from(value: Variant) -> Fade:
	_initial_val = value
	
	return self

func to(value: Variant) -> Fade:
	_final_val = value
	
	return self

func set_duration(value: float) -> Fade:
	_duration = value
	
	return self

func set_callback(value: Callable) -> Fade:
	_callbacks.append(value)
	
	return self

func execute() -> void:
	parent.set_indexed(_property, _initial_val)
	
	var tween: Tween = parent.create_tween().set_trans(Tween.TRANS_SINE)
	
	match _fade_type:
		Type.IN:
			tween.set_ease(Tween.EASE_IN)
		Type.OUT:
			tween.set_ease(Tween.EASE_OUT)
		_:
			tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(parent, _property, _final_val, _duration)
	
	for callback in _callbacks:
		tween.tween_callback(callback)

func _get_val_by_unit(value: Variant) -> Variant:
	match _val_unit:
		"Vector2":
			if value is Vector2:
				return value
			
			return Vector2(value, value)
		_:
			return value

func _set_initial_val(value: Variant) -> void:
	_initial_val = _get_val_by_unit(value)

func _set_final_val(value: Variant) -> void:
	_final_val = _get_val_by_unit(value)
