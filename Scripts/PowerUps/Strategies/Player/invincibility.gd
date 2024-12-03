class_name InvincibilityPowerUp
extends BasePlayerPowerUp


func apply() -> void:
	super.apply()
	
	if player.imortal:
		allowed = false
		return
		
	player.imortal = true

func remove() -> void:
	super.remove()
	
	player.imortal = false
