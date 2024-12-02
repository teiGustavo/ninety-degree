class_name PowerUpDisplay
extends HBoxContainer


@export var texture: CompressedTexture2D
@export var timer_name: StringName

var timer: Timer
var seconds: float = INF:
	set = _set_seconds

@onready var texture_rect: TextureRect = $TextureRect
@onready var seconds_left: Label = $SecondsLeft


func _ready() -> void:
	if not timer_name:
		push_error('Power up timer name is not defined!')
		
	texture_rect.texture = texture
	
	timer = get_tree().get_first_node_in_group(timer_name)

func _process(_delta: float) -> void:
	seconds = timer.time_left

func _set_seconds(value: float) -> void:
	seconds = value
	seconds_left.text = str(ceili(seconds), "s")
