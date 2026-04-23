class_name UITimer extends PanelContainer

@export var bar: ProgressBar
@export var time_label: Label
@export var countdown_label: Label


func initialize(game_controller: GameController, mission_controller: MissionController) -> void:
	game_controller.on_active_time_updated.connect(handle_active_time_updated)
	game_controller.on_countdown_updated.connect(handle_countdown_updated)
	mission_controller.on_last_challenge_shape_added.connect(handle_start_countdown)
	
	handle_end_countdown()
	
	


func handle_active_time_updated(time: float, percent_before_challenge: float) -> void:
	time_label.text = Time.get_time_string_from_unix_time(int(time))
	bar.value = percent_before_challenge

func handle_countdown_updated(number: int) -> void:
	countdown_label.text = str(number) + " PIECES LEFT"

func handle_start_countdown() -> void:
	bar.hide()
	countdown_label.show()
	
func handle_end_countdown() -> void:
	bar.show()
	countdown_label.hide()
