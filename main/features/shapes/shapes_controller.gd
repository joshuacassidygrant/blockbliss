class_name ShapesController extends Node

signal on_new_next_shape
signal on_shape_deck_reshuffle

var _game_state_holder: GameStateHolder
var _shape_library: ShapeLibrary

var state: GameState:
	get: return _game_state_holder.get_state()

func bind_services(gsh: GameStateHolder, shape_library: ShapeLibrary) -> void:
	_game_state_holder = gsh
	_shape_library = shape_library

func next_active_tile_shape() -> void:
	maybe_shuffle_back_discard()
	
	state.current_active_shape = state.shape_stack.pop_front()
	state.shape_discard.append(state.current_active_shape)
	state.current_active_shape.offset = Vector2i(5, 0)
	state.current_active_shape.rotation = 0
	
	maybe_shuffle_back_discard()
	
	on_new_next_shape.emit(state.shape_stack.slice(0, GameConstants.STACK_PREVIEW_WINDOW), 
			state.shape_stack.size(),
			state.shape_discard.size())

func maybe_shuffle_back_discard() -> void:
	if state.shape_stack.size() <= GameConstants.STACK_PREVIEW_WINDOW:
		state.shape_stack.append_array(state.shape_discard)
		state.shape_stack.shuffle()
		on_shape_deck_reshuffle.emit()
