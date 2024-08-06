extends TextureProgress


class_name DifficultyProgress


var _difficulty : float

var difficulty setget , get_difficulty
func get_difficulty():
	return _difficulty


const difficulty_ui_map = {
	0: 0,
	1: 0.85,
	2: 2,
	3: 2.9,
	4: 4,
	5: 5,
	6: 6,
	7: 6.99,
	8: 8,
	9: 9.15,
	10: 10
}


func set_difficulty(difficulty: float):
	_difficulty = difficulty
	
	var difficulty_rounded = ceil(difficulty) as int
	value = difficulty_ui_map[difficulty_rounded]
