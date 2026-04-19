class_name MissionController extends Node

var _shape_library: ShapeLibrary

func bind_services(shape_library: ShapeLibrary) -> void:
	_shape_library = shape_library


func generate_mission() -> MissionState:
	var mission: MissionState = MissionState.new()
	
	fill_up_challenge_shapes(mission)
	
	return mission

func pop_next_challenge_shape(mission_state: MissionState) -> ShapeResource:
	if mission_state.challenge_shapes.size() <= 0:
		fill_up_challenge_shapes(mission_state)

	return mission_state.challenge_shapes.pop_front()

func fill_up_challenge_shapes(mission_state: MissionState) -> void:
		for i in range(0, 3):
			# TODO  7 is  hardcoded
			mission_state.challenge_shapes.append(_shape_library.get_shape_by_index(7 + i))
