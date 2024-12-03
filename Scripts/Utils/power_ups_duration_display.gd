class_name PowerUpsDurationDisplay
extends CanvasLayer


const POWER_UP_DISPLAY: PackedScene = preload(
	"res://Prefabs/Utils/power_up_display.tscn"
)

@onready var v_box_container: VBoxContainer = $VBoxContainer


func add_power_up(
	timer_group_name: StringName, 
	texture: CompressedTexture2D = null
) -> void:	
	var power_up_display: PowerUpDisplay = POWER_UP_DISPLAY.instantiate()

	power_up_display.timer_group_name = timer_group_name
	power_up_display.texture = texture
		
	v_box_container.add_child(power_up_display)
