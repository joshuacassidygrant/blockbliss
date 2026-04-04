class_name GridRenderer extends Node2D

var block_renderer: PackedScene = preload("res://scenes/block_renderer.tscn")
var grid_cell_renderer: PackedScene = preload("res://scenes/grid_cell_renderer.tscn")
var destroy_block_particles: PackedScene = preload("res://scenes/destroy_particles.tscn")

var rendered_blocks: Array[Sprite2D]
var dropping_blocks: Array[Sprite2D]

var game_state: GameState:
	get: return GameStateHolder.game_state

func _ready() -> void:
	Events.on_row_clear.connect(generate_clear_particles)

func initialize() -> void:
	position = Vector2((get_window().size.x / 2.0) - (GameConstants.WIDTH * GameConstants.TILE_SIZE / 2.0), GameConstants.TILE_SIZE / 2.0)
	rendered_blocks.resize(GameConstants.TILE_COUNT)
	draw_grid()
	
func clear_grid() -> void:
	for child: Node in get_children():
		child.queue_free()
	
	for block: Sprite2D in rendered_blocks:
		if block:
			block.queue_free()
	
	for block: Sprite2D in dropping_blocks:
		if block:
			block.queue_free()
	dropping_blocks = []

func draw_grid() -> void:
	clear_grid()
	for x: int in range(0, GameConstants.WIDTH):
		for y: int in range(0, GameConstants.HEIGHT):
			var cell: Node2D = grid_cell_renderer.instantiate()
			add_child(cell)
			cell.position = Grid.address_to_position(Vector2i(x, y))
			

func generate_clear_particles(row: int, values: Array[int]) -> void:
	for i: int in range(GameConstants.WIDTH):
		# render particles
		var particles: GPUParticles2D = destroy_block_particles.instantiate()
		add_child(particles)
		particles.emitting = true
		particles.position = Grid.index_to_position(row * GameConstants.WIDTH + i)
		particles.modulate = Grid.tile_to_color(values[i])
		particles.finished.connect(particles.queue_free)

func update() -> void:
	# checks all rendered tiles; if a tile does not need to be changed, ignores it.
	# otherwise, removes, recolors, or creates it
	
	if game_state.current_active_shape:
		var percentage_of_next_row_dropped: float = (game_state.active_time - game_state.last_drop_time) / game_state.get_total_gravity() 
		var grounded: bool = game_state.is_current_shape_touching_ground()
		
		# create new dropping blocks
		if dropping_blocks.size() != game_state.current_active_shape.tiles.size():
			for dropping_block: Sprite2D in dropping_blocks:
				dropping_block.queue_free()
			dropping_blocks = []
			for tile: Vector2i in game_state.current_active_shape.tiles:
				var block: Sprite2D = block_renderer.instantiate()
				add_child(block)
				dropping_blocks.append(block)
		
		# update dropping blocks
		for tile_index: int in range(0, game_state.current_active_shape.tiles.size()):
			var dropping_block: Sprite2D = dropping_blocks[tile_index]
			var color: Color = Grid.tile_to_color(game_state.current_active_shape.resource.color)
			
			if dropping_block:
				dropping_block.position = Grid.address_to_position(game_state.current_active_shape.tiles[tile_index])\
					+ Vector2(0.0, 0.0 if grounded else percentage_of_next_row_dropped * GameConstants.TILE_SIZE)
				dropping_block.modulate = color

	# TODO: optimize this by only covering changed indices, maybe?
	for i: int in range(GameConstants.TILE_COUNT):
		var rendered_block: Sprite2D = rendered_blocks[i]
		var value: int = game_state.grid[i]
		if !rendered_block and value > 0:
			# create block
			var block: Sprite2D = block_renderer.instantiate()
			add_child(block)
			rendered_blocks[i] = block
			block.position = Grid.index_to_position(i)
			block.modulate = Grid.tile_to_color(value)
		elif rendered_block and value ==  0:
			# destroy block
			rendered_block.queue_free()
		elif rendered_block and rendered_block.modulate != Grid.tile_to_color(value):
			# recolor block
			rendered_block.modulate = Grid.tile_to_color(value)
