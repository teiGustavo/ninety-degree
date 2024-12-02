class_name InvincibilityPowerUp
extends PowerUp


func apply() -> void:
	super.apply()
	
	if target.imortal:
		allowed = false
		return
		
	target.imortal = true

func remove() -> void:
	super.remove()
	
	target.imortal = false
