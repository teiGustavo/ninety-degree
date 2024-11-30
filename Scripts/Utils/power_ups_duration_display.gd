class_name PowerUpsDurationDisplay
extends CanvasLayer

const POWER_UP_DISPLAY: PackedScene = preload(
	"res://Prefabs/Utils/power_up_display.tscn"
)

@onready var v_box_container: VBoxContainer = $VBoxContainer


func add_power_up(power_up: BasePowerUp) -> void:	
	var power_up_display: PowerUpDisplay = POWER_UP_DISPLAY.instantiate()
	
	power_up_display.power_up = power_up
	
	v_box_container.add_child(power_up_display)
	
