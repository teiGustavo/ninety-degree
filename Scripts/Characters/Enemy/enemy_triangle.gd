class_name EnemyTriangle
extends Enemy


func _physics_process(delta: float) -> void:
	velocity = direction * speed * delta
	
	move_based_on_velocity()
	
func _on_collided(collider: Object) -> void:
	super._on_collided(collider)
	
	match collider.get_groups():
		["food"]:
			collider = collider as Food
			collider.fade_queue_free(Food.FADE_DURATION)
