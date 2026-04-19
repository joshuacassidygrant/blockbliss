class_name ShapesController extends Node

signal on_new_next_shape
signal on_shape_removed
signal on_shape_deck_reshuffle

var _game_state_holder: GameStateHolder
var _shape_library: ShapeLibrary
var _mission_controller: MissionController

var state: GameState:
	get: return _game_state_holder.get_state()

func bind_services(gsh: GameStateHolder,
		shape_library: ShapeLibrary,
		mission_controller: MissionController) -> void:
	_game_state_holder = gsh
	_shape_library = shape_library
	_mission_controller = mission_controller

func next_active_tile_shape() -> void:
	maybe_shuffle_back_discard()
	
	state.current_active_shape = state.shape_stack.pop_front()
	var shape: Shape = state.current_active_shape
	shape.usages -= 1
	shape.offset = Vector2i(5, 0)
	shape.rotation = 0

	if shape.usages == 0:
		on_shape_removed.emit()
	else:
		state.shape_discard.append(shape)
	
	maybe_shuffle_back_discard()
	
	on_new_next_shape.emit(state.shape_stack.slice(0, GameConstants.STACK_PREVIEW_WINDOW), 
			state.shape_stack.size(),
			state.shape_discard.size())

func maybe_shuffle_back_discard() -> void:
	if state.shape_stack.size() <= GameConstants.STACK_PREVIEW_WINDOW:
		state.shape_stack.append_array(state.shape_discard)
		state.shape_stack.shuffle()
		on_shape_deck_reshuffle.emit()
		
func generate_challenge_shape() -> void:
	# BUG: It doesn't seem to ever be getting the last shape?
	var shape_res: ShapeResource = _mission_controller.pop_next_challenge_shape(_game_state_holder.game_state.mission)
	var shape: Shape = Shape.new( Vector2i(5, 0), shape_res)
	state.shape_discard.append(shape)
