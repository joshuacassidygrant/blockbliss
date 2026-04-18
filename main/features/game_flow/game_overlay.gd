class_name GameOverlay extends Node

@export var score_box: ScoreBox
@export var next_piece_renderer: NextPieceRenderer 

func initialize(score_controller: ScoreController,\
		shapes_controller: ShapesController) -> void:
			
	score_box.initialize(score_controller)
	
	shapes_controller.on_new_next_shape.connect(next_piece_renderer.on_new_next_shape.emit)
	next_piece_renderer.initialize()
