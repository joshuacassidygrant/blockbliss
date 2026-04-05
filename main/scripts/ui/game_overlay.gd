class_name GameOverlay extends Node

@export var score_box: ScoreBox
@export var next_piece_renderer: NextPieceRenderer 

func initialize(gsh: GameStateHolder) -> void:
	score_box.initialize(gsh)
	next_piece_renderer.initialize(gsh)
