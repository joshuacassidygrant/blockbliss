class_name MissionController extends Node

signal on_last_challenge_shape_added

var _shape_library: ShapeLibrary
var _game_state_holder: GameStateHolder

var state: GameState:
	get: return _game_state_holder.get_state()

func bind_services(shape_library: ShapeLibrary, game_state_holder: GameStateHolder) -> void:
	_shape_library = shape_library
	_game_state_holder = game_state_holder
	
func setup() -> void:
	on_last_challenge_shape_added.connect(start_shape_countdown)

func start_shape_countdown() -> void:
	state.drops_until_end_mission = 15
	

func generate_mission(config: MissionConfig) -> MissionState:
	var mission: MissionState = MissionState.new()
	
	fill_up_challenge_shapes(mission, config)
	
	return mission

func pop_next_challenge_shape(mission_state: MissionState) -> ShapeResource:
	if mission_state.challenge_shapes.size() <= 0:
		# this is probably the win state?
		return null

	return mission_state.challenge_shapes.pop_front()

func fill_up_challenge_shapes(mission_state: MissionState, mission_config: MissionConfig) -> void:
		for shape in mission_config.challenge_shapes:
			mission_state.challenge_shapes.append(shape)
