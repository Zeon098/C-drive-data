extends DifficultyProgress


export var selection_offset := Vector2(20, 50)


func _input(event):
	if event is InputEventScreenDrag or event is InputEventScreenTouch:
		_set_difficulty(event.position)


func _set_difficulty(position: Vector2):
	var test_rect = Rect2(get_global_rect().position - selection_offset,
			(get_global_rect().size * rect_scale) + (2 * selection_offset))
	if test_rect.has_point(position):
		var difficulty = (position.x - get_global_rect().position.x) \
				/ (rect_size.x * rect_scale.x) * 10
		difficulty = clamp(difficulty, 0, 10)
		set_difficulty(difficulty)
