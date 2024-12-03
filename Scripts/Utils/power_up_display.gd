class_name PowerUpDisplay
extends HBoxContainer


@export var texture: CompressedTexture2D
@export var timer_group_name: StringName
@export var auto_destroy_at_0: bool = true

var timer: Timer

@onready var texture_rect: TextureRect = $TextureRect
@onready var seconds_left: Label = $SecondsLeft


func _ready() -> void:
	if not timer_group_name:
		push_error('Power up timer name is not defined!')
		
	texture_rect.texture = texture
	
	timer = get_tree().get_first_node_in_group(timer_group_name)
	
	if not timer:
		push_error(
			'%s is not found! (The timer group name is probably incorrect)' 
				% timer_group_name
		)

func _process(_delta: float) -> void:
	if timer.time_left == 0:
		queue_free()
	
	seconds_left.text = str(ceili(timer.time_left), "s")
