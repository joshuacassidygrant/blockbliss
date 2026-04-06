class_name GameCamera extends Camera2D

signal request_shake_screen

const MAX_SHAKE: float = 5.0

var home_position: Vector2
var current_shake: Tween

func initialize() -> void:
	home_position = get_window().size / 2
	position = home_position
	request_shake_screen.connect(shake_screen)
	
func shake_screen(_row: int, _values: Array[int]) -> void:
	if not current_shake or not current_shake.is_running():
		current_shake = get_tree().create_tween()
		current_shake.tween_property(self, "position", home_position + Vector2(randf_range(-MAX_SHAKE, MAX_SHAKE), randf_range(-MAX_SHAKE, MAX_SHAKE)), 0.05)
		current_shake.tween_property(self, "position", home_position + Vector2(randf_range(-MAX_SHAKE, MAX_SHAKE), randf_range(-MAX_SHAKE, MAX_SHAKE)), 0.05)
		current_shake.tween_property(self, "position", home_position + Vector2(randf_range(-MAX_SHAKE, MAX_SHAKE), randf_range(-MAX_SHAKE, MAX_SHAKE)), 0.05)
		current_shake.tween_property(self, "position", home_position + Vector2(randf_range(-MAX_SHAKE, MAX_SHAKE), randf_range(-MAX_SHAKE, MAX_SHAKE)), 0.05)
		current_shake.tween_property(self, "position", home_position, 0.05)

	
