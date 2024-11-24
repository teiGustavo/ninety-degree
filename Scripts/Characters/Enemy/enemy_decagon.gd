class_name EnemyDecagon
extends BaseEnemy


const FADE_DURATION: float = 2
const INFINITE_FADE_FINAL_SCALE: float = 1.7


func _ready() -> void:
	super._ready()
	
	_infinite_fade()

func _physics_process(delta: float) -> void:
	velocity = direction * speed * delta
	
	move_based_on_velocity()

func _fade_in() -> void:
	fade.fade_in().scale().from(scale).to(INFINITE_FADE_FINAL_SCALE) \
		.set_duration(FADE_DURATION) \
		.set_callback(_fade_out).execute()

func _fade_out() -> void:
	fade.fade_out().scale().from(scale).to(1) \
		.set_duration(FADE_DURATION) \
		.set_callback(_fade_in).execute()

func _infinite_fade() -> void:		
	_fade_in()
