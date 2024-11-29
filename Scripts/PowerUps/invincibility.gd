class_name InvincibilityPowerUp
extends BasePowerUp


func on_collected() -> void:
	player.imortal = true
	
func on_expired() -> void:
	player.imortal = false
