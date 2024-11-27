class_name Scoreboard
extends CanvasLayer


@onready var score: Label = $Score
@onready var fade: Fade = Fade.new(score)


func set_score(new_score: String) -> void:
	score.text = new_score
	fade.fade_in().scale().to(1).set_duration(0.1).execute()
