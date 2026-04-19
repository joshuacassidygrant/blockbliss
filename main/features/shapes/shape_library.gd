class_name ShapeLibrary extends Node

@export
var shapes: Array[ShapeResource]

func get_random_shape() -> ShapeResource:
	return shapes.pick_random()

# temp
func get_shape_by_index(i: int) -> ShapeResource:
	return shapes[i]
