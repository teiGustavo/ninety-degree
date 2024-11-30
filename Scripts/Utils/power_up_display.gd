class_name PowerUpDisplay
extends HBoxContainer


@export var power_up: BasePowerUp

var seconds: float = INF:
	set = _set_seconds

@onready var texture_rect: TextureRect = $TextureRect
@onready var seconds_left: Label = $SecondsLeft


func _ready() -> void:
	if not power_up:
		push_error('Power up is not defined!')
		
	power_up.tree_exited.connect(queue_free)
	
	texture_rect.texture = power_up.sprite_2d.texture

func _process(_delta: float) -> void:
	seconds = power_up.duration_time_left

func _set_seconds(value: float) -> void:
	seconds = value
	seconds_left.text = str(seconds, "s")
