class_name TimeLeft
extends CanvasLayer


@export var texture: CompressedTexture2D

var seconds: float = 0:
	set = _set_seconds

@onready var texture_rect: TextureRect = $HBoxContainer/TextureRect
@onready var seconds_left: Label = $HBoxContainer/SecondsLeft


func _ready() -> void:
	texture_rect.texture = texture

func _set_seconds(value: float) -> void:
	seconds = value
	seconds_left.text = str(seconds, "s")
