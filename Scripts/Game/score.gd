class_name Score
extends CanvasLayer


@onready var value: Label = $Value
@onready var fade: Fade = Fade.new(value)


func set_score(new_score: String) -> void:
	value.text = new_score
	fade.fade_in().scale().set_duration(0.1).execute()
