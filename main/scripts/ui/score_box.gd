class_name ScoreBox extends PanelContainer

var _game_state_holder: GameStateHolder

@export 
var score_display_label: Label

func initialize(gsh: GameStateHolder) -> void:
	bind_services(gsh)
	bind_events()
	if _game_state_holder.game_state:
		update_score(_game_state_holder.game_state.score)


func bind_services(gsh: GameStateHolder) -> void:
	_game_state_holder = gsh

	
func bind_events() -> void:
	Events.on_score_updated.connect(update_score)

func update_score(value: int) -> void:
	score_display_label.text = str(value).lpad(8, "0")
