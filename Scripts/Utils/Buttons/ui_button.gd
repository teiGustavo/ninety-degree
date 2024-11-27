class_name UIButton
extends TextureButton


const BUTTON_CLICK_SOUND: Resource = preload(
	"res://Assets/Sounds/button_click.wav"
)

func _pressed() -> void:
	SoundManager.play_ui_sound(BUTTON_CLICK_SOUND)
