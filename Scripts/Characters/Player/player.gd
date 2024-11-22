class_name Player
extends BaseCharacter


signal food_collected
signal died

const DODGE_SOUND: Resource = preload("res://Assets/Sounds/dodge.wav")
const DEATH_SOUND: Resource = preload("res://Assets/Sounds/death.wav")
const COIN_SOUND: Resource = preload("res://Assets/Sounds/coin.wav")
const BASE_SPEED: float = 250.0
const SCALE_INCREASE_INTERVAL: float = 1.0

@export_group("Cheats")
@export var imortal: bool = false
@export var no_scale_up: bool = false
@export_group("Variables")
@export_subgroup("Movement")
@export_enum("UP", "DOWN", "LEFT", "RIGHT") var initial_degree: int
@export_subgroup("Scale Up")
@export_range(0.01, 0.3, 0.01) var scale_increase: float = 0.05
@export_range(1, 3, 0.1) var max_scale: float = 1.7

var current_degree: Vector2
var is_dead: bool = false

@onready var scale_up_cooldown_timer: Timer = $ScaleUpCooldownTimer
@onready var no_scale_up_cooldown_timer: Timer = $NoScaleUpCooldownTimer


func _init() -> void:
	if speed_is_empty():
		speed = BASE_SPEED

func _ready() -> void:
	super._ready()
	
	add_to_group("player")
	
	var degrees: Array[Vector2] = [
		Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT
	]
	current_degree = degrees[initial_degree]
	
	scale_up_cooldown_timer.wait_time = SCALE_INCREASE_INTERVAL
	scale_up_cooldown_timer.autostart = true
	no_scale_up_cooldown_timer.one_shot = true
	scale_up_cooldown_timer.timeout.connect(_on_scale_up_cooldown_timer_timeout)
	
	no_scale_up_cooldown_timer.wait_time = SCALE_INCREASE_INTERVAL
	no_scale_up_cooldown_timer.autostart = false
	no_scale_up_cooldown_timer.one_shot = true
	no_scale_up_cooldown_timer.timeout.connect(
		_on_no_scale_up_cooldown_timer_timeout
	)
	
	update_safety_margin()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("change_degree"):
		toggle_current_degree()
	
	direction = current_degree
	velocity = direction * speed * delta
	
	move_based_on_velocity()

func toggle_current_degree() -> void:
	match current_degree:
		Vector2.UP:
			current_degree = Vector2.LEFT
		Vector2.LEFT:
			current_degree = Vector2.DOWN
		Vector2.DOWN:
			current_degree = Vector2.RIGHT
		Vector2.RIGHT:
			current_degree = Vector2.UP
		_:
			current_degree = Vector2.UP
	
	SoundManager.play_sound(DODGE_SOUND)

func increase_scale(increasement: float = scale_increase) -> void:
	if increasement < 1:
		increasement += 1
		
	if scale.x * increasement <= max_scale:
		fade.fade_in().scale().from(scale).to(scale * increasement) \
			.set_duration(0.5).execute()
	elif scale.x < max_scale:
		fade.fade_in().scale().from(scale).to(max_scale) \
			.set_duration(0.5).execute()
			
func reset_scale() -> void:
	fade.fade_out().scale().to(1).set_duration(1).execute()

func collect_food() -> void:
	SoundManager.play_sound(COIN_SOUND)
	reset_scale()
	food_collected.emit()
	
	scale_up_cooldown_timer.stop()
	no_scale_up_cooldown_timer.start()
	
func clamp_position() -> void:
	if imortal:
		update_safety_margin()
		super.clamp_position()

func fade_queue_free(
	duration: float = 1, 
	callback: Callable = Callable()
) -> void:
	scale_up_cooldown_timer.stop()
	no_scale_up_cooldown_timer.stop()
	no_scale_up = true
	
	super.fade_queue_free(duration, callback)

func die() -> void:
	if imortal:
		return
	
	if not is_dead:
		is_dead = true
		SoundManager.play_sound(DEATH_SOUND)
		fade_queue_free(1, died.emit)

func _on_collided_with_edge() -> void:
	die()

func _on_collided(collider: Object) -> void:
	match collider.get_groups():
		["food"]:
			collider = collider as Food
			collider.fade_queue_free(Food.FADE_DURATION)
			collect_food()
		["enemy"]:
			collider = collider as Enemy
			collider.fade_queue_free()
			die()
	
	if not collider.has_method("fade_queue_free"):
		collider.queue_free()
		
func _on_scale_up_cooldown_timer_timeout() -> void:
	if not no_scale_up:
		increase_scale()
	
	scale_up_cooldown_timer.start()

func _on_no_scale_up_cooldown_timer_timeout() -> void:
	scale_up_cooldown_timer.start()
