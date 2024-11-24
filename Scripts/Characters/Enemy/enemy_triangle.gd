class_name EnemyTriangle
extends BaseEnemy


const DEATH_SOUND: Resource = preload("res://Assets/Sounds/death.wav")


func _physics_process(delta: float) -> void:
	velocity = direction * speed * delta
	
	move_based_on_velocity()
	
func _on_collided(collider: Object) -> void:
	super._on_collided(collider)
	
	match collider.get_groups():
		["food"]:
			collider = collider as Food
			SoundManager.play_sound(DEATH_SOUND)
			collider.fade_queue_free(Food.FADE_DURATION)
