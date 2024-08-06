extends Node


signal choice_completed


enum Direction { LEFT, RIGHT, UP, DOWN }


onready var view_animator : ViewAnimator = $ViewAnimator

var views = {}


func _ready():
	# Preload the view scenes.
	var views_dir = Directory.new()
	var error = views_dir.open("res://views")
	
	if error:
		Logger.warn("Could not open view directory: %s", error)
	
	views_dir.list_dir_begin()
	var file_name = views_dir.get_next()
	while file_name:
		if not views_dir.current_is_dir():
			Logger.info("Preloading view %s" % file_name)
			var resource_path = "res://views/%s" % file_name
			var view = _create_view_from_path(resource_path)
			AudioEngine.setup_button_sound(view)
			views[file_name.get_basename()] = view
		file_name = views_dir.get_next()
	
	views_dir.list_dir_end()


func move_to_view(from_view: Node, view_name: String, direction: int,
			params: Dictionary = {}):
	if not views.has(view_name):
		Logger.warn("Requested view %s does not exist." % view_name)
		return
	
	_show_view(view_name, direction, params)
	
	yield(view_animator.hide_view(from_view, direction), "completed")
	
	var root = get_tree().get_root()
	root.remove_child(from_view)


func _show_view(view_name: String, direction: int, params: Dictionary = {}):
	if not views.has(view_name):
		Logger.warn("Requested view %s does not exist." % view_name)
		return
	
	var new_view = views[view_name]
	
	var root = get_tree().get_root()
	root.add_child(new_view)
	
	view_animator.show_view(new_view, direction, params)
	
	return new_view


func move_to_view_no_transition(from_view: Node, view_name: String):
	if not views.has(view_name):
		Logger.error("View can not be found: " + view_name)
		return
	
	var new_view = views[view_name]
	
	var root = get_tree().get_root()
	root.add_child(new_view)
	new_view.rect_position.x = 0
	
	root.remove_child(from_view)


func block_screen(message: String, duration = 0):
	var blocker = $CanvasLayer/Blocker
	$CanvasLayer/Blocker/Label.text = message
	
	blocker.visible = true
	if blocker.modulate.a < 0.001:
		$BlockTween.remove_all()
		$BlockTween.interpolate_property(blocker, "modulate:a", 0, 1, 0.2, \
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$BlockTween.start()
	
	if duration > 0:
		yield(get_tree().create_timer(duration), "timeout")
		unblock_screen()


func unblock_screen():
	var blocker = $CanvasLayer/Blocker
	
	if blocker.modulate.a < 0.001:
		yield(get_tree(), "idle_frame")
		return
	
	$BlockTween.remove_all()
	$BlockTween.interpolate_property(blocker, "modulate:a", blocker.modulate.a, 0,
			0.2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$BlockTween.start()
	yield($BlockTween, "tween_all_completed")
	blocker.visible = false


func show_choice_dialog(choice_text: String):
	var choice_dialog = _show_view("choice_dialog", Direction.DOWN)
	choice_dialog.connect("choice_selected", self, "choice_completed")
	choice_dialog.set_choice_text(choice_text)


func show_dialog(dialog_name: String, parameters: Dictionary = {},
		direction: int = Direction.DOWN):
	var dialog = _show_view(dialog_name, direction, parameters)


func hide_dialog(dialog_node: Node, direction: int = Direction.UP):
	yield(view_animator.hide_view(dialog_node, direction), "completed")
	
	var root = get_tree().get_root()
	root.remove_child(dialog_node)
	
	emit_signal("completed")


func choice_completed(result: String):
	emit_signal("choice_completed", result)


func _create_view_from_path(view_path):
	# Load the new scene.
	var new_view_resource = ResourceLoader.load(view_path)
	
	if not new_view_resource:
		Logger.error("View can not be found: " + view_path)
		return
	
	var new_view = new_view_resource.instance()
	return new_view
