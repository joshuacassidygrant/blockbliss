class_name ScoreBox extends PanelContainer

var _score_controller: ScoreController

@export 
var score_display_label: Label

func initialize(score_controller: ScoreController) -> void:
	bind_services(score_controller)
	bind_events()

func bind_services(score_controller: ScoreController) -> void:
	_score_controller = score_controller
	
func bind_events() -> void:
	_score_controller.on_score_updated.connect(update_score)

func update_score(value: int) -> void:
	score_display_label.text = str(value).lpad(8, "0")
