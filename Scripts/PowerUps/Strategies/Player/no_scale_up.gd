class_name NoScaleUpPowerUp
extends PowerUp


func apply() -> void:
	super.apply()
	
	if target.no_scale_up:
		allowed = false
		return
	
	target.no_scale_up = true
	target.reset_scale()
	
func remove() -> void:
	super.remove()
	
	target.no_scale_up = false
