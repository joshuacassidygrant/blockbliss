class_name UITimer extends PanelContainer

@export var bar: ProgressBar
@export var time_label: Label

func initialize(game_controller: GameController) -> void:
	game_controller.on_active_time_updated.connect(handle_active_time_updated)


func handle_active_time_updated(time: float, percent_before_challenge: float) -> void:
	time_label.text = Time.get_time_string_from_unix_time(int(time))
	bar.value = percent_before_challenge
