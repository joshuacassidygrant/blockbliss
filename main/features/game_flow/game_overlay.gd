class_name GameOverlay extends Node

@export var score_box: ScoreBox
@export var next_piece_renderer: NextPieceRenderer 

func initialize(score_controller: ScoreController,\
		grid_controller: GridController) -> void:
			
	score_box.initialize(score_controller)
	
	grid_controller.on_new_next_shape.connect(next_piece_renderer.on_new_next_shape.emit)
	next_piece_renderer.initialize()
