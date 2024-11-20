class_name Food
extends BaseCharacter


enum MovementMode {
	IDLE,
	HORIZONTAL,
	AROUND_EDGES,
	LEMNISCATE,
	HOURGLASS,
}

const BASE_SPEED: float = 110

@export_group("Movement")
@export var movement_mode: MovementMode = MovementMode.IDLE:
	set = _set_movement_mode

var movement_mode_implementations: Dictionary = {
	MovementMode.IDLE: IdleMovement,
	MovementMode.HORIZONTAL: HorizontalMovement,
	MovementMode.AROUND_EDGES: AroundEdgesMovement,
	MovementMode.LEMNISCATE: LemniscateMovement,
	MovementMode.HOURGLASS: HourglassMovement
}
var movement: Movement

@onready var shape: CircleShape2D = $CollisionShape2D.shape
@onready var collision_margin: float = shape.radius


func _init() -> void:
	if speed_is_empty():
		speed = BASE_SPEED

func _ready() -> void:
	super._ready()
		
	add_to_group("food")
	
	collision_shape = $CollisionShape2D
	screen_limits.safety_margin.add(Direction4.from_float(collision_margin))
	
	movement = get_movement_from_moviment_mode(MovementMode.IDLE)
	
	fade.fade_in().scale().from(0.4).set_duration(0.3) \
		.set_callback(_set_movement_mode.bind(movement_mode)).execute()
		
func _physics_process(delta: float) -> void:
	movement.set_food_direction()
	velocity = direction * speed * delta
	position += velocity

	clamp_position()

func get_movement_from_moviment_mode(target_movement_mode: MovementMode) -> Movement:
	return movement_mode_implementations[target_movement_mode].new(self)

func _set_movement_mode(value: MovementMode) -> void:
	movement_mode = value
	movement = get_movement_from_moviment_mode(movement_mode)
