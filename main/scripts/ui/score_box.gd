extends PanelContainer

@export 
var score_display_label: Label

func _ready() -> void:
	bind_events()
	if GameStateHolder.game_state:
		update_score(GameStateHolder.game_state.score)
	
func bind_events() -> void:
	Events.on_score_updated.connect(update_score)

func update_score(value: int) -> void:
	score_display_label.text = str(value).lpad(8, "0")
