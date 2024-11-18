class_name FpsCounter
extends HBoxContainer


var fps: float = 0

@onready var counter: Label = $Counter


func _physics_process(_delta: float) -> void:
	fps = Engine.get_frames_per_second()
	counter.text = str(fps)
