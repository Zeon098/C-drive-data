extends Node


class_name ViewAnimator


onready var window_width = ProjectSettings.get_setting(
		"display/window/size/width")
onready var window_height = ProjectSettings.get_setting(
		"display/window/size/height")


func _ready():
	pass


func show_view(view: Node, direction: int, params: Dictionary = {}):
	var start_pos = _get_start_position(direction)
	
	if view.has_method("will_become_visible"):
		view.will_become_visible()
	if not params.empty() and view.has_method("receive_params"):
		view.receive_params(params)
	
	#view.rect_position.x = 720
#	var screen_width = get_viewport().size.x
#	Logger.debug("Screen width %s" % screen_width)
#	view.rect_position.x = screen_width
	
	$ShowViewTween.remove_all()
	$ShowViewTween.interpolate_property(view, "rect_position", start_pos,
			Vector2.ZERO, 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$ShowViewTween.start()
	
	yield($ShowViewTween, "tween_all_completed")
	if view.has_method("did_become_visible"):
		view.did_become_visible()


func hide_view(view: Node, direction: int):
	var start_pos = _get_start_position(direction)
	
	$HideViewTween.remove_all()
	$HideViewTween.interpolate_property(view, "rect_position", Vector2.ZERO,
			-start_pos, 0.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$HideViewTween.start()
	
	yield($HideViewTween, "tween_all_completed")


func _get_start_position(direction: int):
	var window_width = get_viewport().size.x * 2
	var window_height = get_viewport().size.y * 2
	Logger.debug("Window height %s" % window_height)
	
	var start_pos = Vector2.ZERO
	match direction:
		ViewManager.Direction.RIGHT:
			start_pos = Vector2(window_width, 0)
		ViewManager.Direction.LEFT:
			start_pos = Vector2(-window_width, 0)
		ViewManager.Direction.UP:
			start_pos = Vector2(0, window_height)
		ViewManager.Direction.DOWN:
			start_pos = Vector2(0, -window_height)
	
	return start_pos
