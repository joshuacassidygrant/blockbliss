class_name GameOverlay extends Node

@export var score_box: ScoreBox
@export var next_piece_renderer: NextPieceRenderer 
@export var ui_timer: UITimer

func initialize(score_controller: ScoreController,
		shapes_controller: ShapesController,
		game_controller: GameController) -> void:
			
	score_box.initialize(score_controller)
	
	shapes_controller.on_new_next_shape.connect(next_piece_renderer.on_new_next_shape.emit)
	next_piece_renderer.initialize()
	
	ui_timer.initialize(game_controller)
