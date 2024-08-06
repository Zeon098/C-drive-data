extends Control


export(float) var max_keyboard_height = 5000

var _current_keyboard_height = 0



func _process(delta):
	var keyboard_height = OS.get_virtual_keyboard_height()
	keyboard_height = clamp(keyboard_height, 0, max_keyboard_height)
	
	if keyboard_height != _current_keyboard_height:
		Logger.debug("Setting keyboard height to %s from %s" % [keyboard_height,
				_current_keyboard_height])
		_current_keyboard_height = keyboard_height
		$Tween.remove_all()
		$Tween.interpolate_property(get_parent(), "rect_position:y",
				get_parent().rect_position.y, -keyboard_height, 0.3,
				Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$Tween.start()
