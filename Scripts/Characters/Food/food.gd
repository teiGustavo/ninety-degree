class_name Food
extends BaseCharacter


signal collected

enum MovementMode {
	IDLE,
	HORIZONTAL,
	AROUND_EDGES,
	LEMNISCATE,
	HOURGLASS,
}

const BASE_SPEED: float = 110
const FADE_DURATION: float = 0.2

@export var movement_mode: MovementMode = MovementMode.IDLE:
	set = _set_movement_mode
@export var auto_reespawn: bool = true

var movement_mode_implementations: Dictionary = {
	MovementMode.IDLE: IdleMovement,
	MovementMode.HORIZONTAL: HorizontalMovement,
	MovementMode.AROUND_EDGES: AroundEdgesMovement,
	MovementMode.LEMNISCATE: LemniscateMovement,
	MovementMode.HOURGLASS: HourglassMovement
}
var movement: Movement


func _init() -> void:
	if speed_is_empty():
		speed = BASE_SPEED
		
func _ready() -> void:
	super._ready()
		
	add_to_group("food")
	
	movement = get_movement_from_moviment_mode(MovementMode.IDLE)
	
	fade.fade_in().scale().from(0.4).set_duration(FADE_DURATION) \
		.set_callback(_set_movement_mode.bind(movement_mode)).execute()
		
	tree_exiting.connect(_on_tree_exiting)
	
	clamp_position()
		
func _physics_process(delta: float) -> void:
	movement.set_food_direction()
	velocity = direction * speed * delta
	position += velocity

	clamp_position()

func get_movement_from_moviment_mode(
	target_movement_mode: MovementMode
) -> Movement:
	return movement_mode_implementations[target_movement_mode].new(self)

func _set_movement_mode(value: MovementMode) -> void:
	movement_mode = value
	movement = get_movement_from_moviment_mode(movement_mode)

func _on_tree_exiting() -> void:
	collected.emit()
