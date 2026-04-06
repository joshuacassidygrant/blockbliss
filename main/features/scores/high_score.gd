class_name HighScore

var name: String 
var score: int

func _init(nm: String, scr: int) -> void:
	name = nm 
	score = scr
	
func to_dict() -> Dictionary:
	var json_dict: Dictionary = {"name": name, "score": score}
	return json_dict
