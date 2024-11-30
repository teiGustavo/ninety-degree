class_name NoScaleUpPowerUp
extends BasePowerUp


func apply() -> void:
	super.apply()
	
	if player.no_scale_up:
		allowed = false
		return
	
	player.no_scale_up = true
	player.reset_scale()
	
func revert() -> void:
	super.revert()
	
	player.no_scale_up = false
