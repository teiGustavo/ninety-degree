class_name Enemy
extends BaseEnemy


func _physics_process(delta: float) -> void:
	velocity = direction * speed * delta
	
	move_based_on_velocity()
