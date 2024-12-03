class_name NoScaleUpPowerUp
extends BasePlayerPowerUp


func apply() -> void:
	super.apply()
	
	if player.no_scale_up:
		allowed = false
		return
	
	player.no_scale_up = true
	player.reset_scale()
	
func remove() -> void:
	super.remove()
	
	player.no_scale_up = false
