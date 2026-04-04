extends PanelContainer

@export var start_button: Button
@export var scores_button: Button
@export var quit_button: Button

func _ready() -> void:
	bind_events()

func bind_events() -> void:
	start_button.pressed.connect(on_press_start)
	
	scores_button.pressed.connect(on_press_scores)

	quit_button.pressed.connect(on_press_quit)

	Events.request_hide_menu.connect(hide_menu)
	Events.request_dismiss_loss.connect(show_menu)
	Events.request_dismiss_highscores.connect(show_menu)
	
	@warning_ignore("unsafe_method_access")
	Music.play_menu_track()


func on_press_start() -> void:
	@warning_ignore("unsafe_method_access")
	Sfx.request_sound(SFX.Key.SELECT)
	Events.request_start_game.emit()

func on_press_scores() -> void:
	Events.request_menu_scores.emit()
	hide()

func on_press_quit() -> void:
	Events.request_quit.emit()

func hide_menu() -> void:
	visible = false
	
func show_menu() -> void:
	visible = true
	@warning_ignore("unsafe_method_access")
	Music.play_menu_track()
