class_name NoScaleUpPowerUp
extends BasePowerUp


func on_collected() -> void:
	player.no_scale_up = true
	player.reset_scale()
	
func on_expired() -> void:
	player.no_scale_up = false
