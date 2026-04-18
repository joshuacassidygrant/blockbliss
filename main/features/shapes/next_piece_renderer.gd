class_name NextPieceRenderer extends PanelContainer

signal on_new_next_shape

@export var piece_frames: Array[Control]
@export var empty_cell_sprite: Texture2D
@export var tile_sprite: Texture2D
@export var deck_count_label: Label
@export var discard_count_label: Label

const WIDTH: int = 5
const HEIGHT: int = 5
const OFFSET: int = 2
const FRAME_OFFSET: Vector2 = Vector2(16, 0)

func initialize() -> void:
	bind_listeners()

func bind_listeners() -> void:
	on_new_next_shape.connect(render_next_pieces)

func render_next_pieces(shapes: Array[Shape], deck_size: int, discard_size: int) -> void:
	clear()
	
	update_labels(deck_size, discard_size)
	
	assert(shapes.size() == GameConstants.STACK_PREVIEW_WINDOW, "Shapes size not equal to preview window")

	for i in range(0, GameConstants.STACK_PREVIEW_WINDOW):
		for x: int in range(WIDTH):
			for y: int in range(HEIGHT):
					var cell: Sprite2D = Sprite2D.new()
					piece_frames[i].add_child(cell)
					cell.position = (Vector2(x, y) * GameConstants.TILE_SIZE) + Vector2(0, 0.5 * GameConstants.TILE_SIZE) + FRAME_OFFSET
					
					if shape_has_tile_at_position(shapes[i], x - OFFSET, y - OFFSET):
						cell.texture = tile_sprite
						cell.modulate = Grid.tile_to_color(shapes[i].resource.color)
					else:
						cell.texture = empty_cell_sprite

func shape_has_tile_at_position(piece: Shape, x: int, y: int) -> bool:
	return piece.resource.offsets.any(func(t: Vector2i) -> bool: return t.x == x and t.y == y)

func clear() -> void:
	for piece_frame in piece_frames:
		for child: Node in piece_frame.get_children():
			child.queue_free()

func update_labels(deck_size: int, discard_size: int) -> void:
	deck_count_label.text = str(deck_size)
	discard_count_label.text = str(discard_size)
	
