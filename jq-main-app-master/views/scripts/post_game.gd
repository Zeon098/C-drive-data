extends Control


var _round_data : RoundData
var _show_difficulty_panel = false
onready var _fade_in_tween = Tween.new()

var _ui_animation_skipped = false


func _ready():
	add_child(_fade_in_tween)
		
	$Panel/MouseBlocker.visible = true


func _input(event):
	if event is InputEventMouseButton and \
			event.button_index == BUTTON_LEFT and event.pressed:
		_skip_ui_animation()


func will_become_visible():
	_ui_animation_skipped = false
	$Panel/GameInfo/RoundPoints.modulate.a = 0
	$Panel/GameInfo/Answers.modulate.a = 0
	$Panel/GameInfo/EndPoints.modulate.a = 0
	$Panel/GameInfo/NewDifficulty.modulate.a = 0
	$Panel/Buttons/AnalysisButton.modulate.a = 0
	$Panel/Buttons/ContinueButton.modulate.a = 0
	$Panel/Buttons/MainMenuButton.modulate.a = 0
	
	$Panel/MouseBlocker.visible = true


func receive_params(params):
	_round_data = params.round_data
	
	var round_results = _setup_data()
	_setup_postgame_info(
		round_results.round_points,
		round_results.correct_answers_count,
		round_results.total_questions_count,
		round_results.show_difficulty
	)
	
	var request = ClientAPI.submit_question_stats(_round_data.question_stats)
	var response = yield(request, "request_completed")
	
	if response.code == 200:
		var body = response.body as Dictionary
		
		var difficulty = body.difficulty
		if abs(difficulty - PlayerData.difficulty_level) > 0.001:
			Logger.warn("Player difficulty calculation differs on backend from " +
					"client. Client value: %s, backend value: %s" \
					% [PlayerData.difficulty_level, difficulty])
		
		var jannah_points = body.points_total
		if abs(jannah_points - PlayerData.jannah_points) > 0.001:
			Logger.warn("Jannah points calculation differs on backend from " +
					"client. Client value: %s, backend value: %s" \
					% [PlayerData.jannah_points, jannah_points])
	else:
		Logger.warn("Unable to submit question stats with error: %s" %
				response.error_string)


func did_become_visible():
	yield(get_tree().create_timer(0.5), "timeout")
	
	var time_interval = 1.0
	
	_fade_in($Panel/GameInfo/RoundPoints)
	yield(get_tree().create_timer(time_interval), "timeout")
	
	if _ui_animation_skipped: return
	_fade_in($Panel/GameInfo/Answers)
	yield(get_tree().create_timer(time_interval), "timeout")
	
	if _ui_animation_skipped: return
	_fade_in($Panel/GameInfo/EndPoints)
	yield(get_tree().create_timer(time_interval), "timeout")
	
	if _show_difficulty_panel:
		if _ui_animation_skipped: return
		_fade_in($Panel/GameInfo/NewDifficulty)
		yield(get_tree().create_timer(time_interval), "timeout")
	
	if _ui_animation_skipped: return
	_fade_in($Panel/Buttons/AnalysisButton)
	yield(get_tree().create_timer(time_interval / 3), "timeout")
	
	if _ui_animation_skipped: return
	_fade_in($Panel/Buttons/ContinueButton)
	yield(get_tree().create_timer(time_interval / 3), "timeout")
	
	if _ui_animation_skipped: return
	_fade_in($Panel/Buttons/MainMenuButton)
	
	$Panel/MouseBlocker.visible = false


func _skip_ui_animation():
	if $Panel/Buttons/MainMenuButton.modulate.a > .999:
		return
	
	_ui_animation_skipped = true
	_fade_in_all()


func _fade_in(node):
	AudioEngine.play_sound("Sfx", "stats_appear")
	_fade_in_tween.remove_all()
	_fade_in_tween.interpolate_property(node, "modulate:a", 0,
			1, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	_fade_in_tween.start()



func _fade_in_all():
	AudioEngine.play_sound("Sfx", "button_click")
	_fade_in_tween.remove_all()
	var ui_elements = [
		$Panel/GameInfo/RoundPoints,
		$Panel/GameInfo/Answers,
		$Panel/GameInfo/EndPoints,
		$Panel/GameInfo/NewDifficulty,
		$Panel/Buttons/AnalysisButton,
		$Panel/Buttons/ContinueButton,
		$Panel/Buttons/MainMenuButton
	]
	
	for ui_element in ui_elements:
		_fade_in_additive(ui_element)
	
	_fade_in_tween.start()
	
	yield(_fade_in_tween, "tween_all_completed")
	$Panel/MouseBlocker.visible = false


func _fade_in_additive(node):
	if node.modulate.a > 0.999:
		return
	
	_fade_in_tween.interpolate_property(node, "modulate:a", node.modulate.a,
			1, 0.3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)


func _setup_data() -> Dictionary:
	var answer_score = _round_data.score_answers_count * 0.2
	var slowdown = GameData.difficulty_progression_slowdown
	if slowdown > 0:
		answer_score /= slowdown
		print_debug("Slowed down difficulty progression by %s" % slowdown)
	
	var old_difficulty_level = PlayerData.difficulty_level
	var old_difficulty_rounded = ceil(PlayerData.difficulty_level)
	PlayerData.update_player_stats(_round_data.round_points, answer_score)
	var new_difficulty_rounded = ceil(PlayerData.difficulty_level)
	
	print_debug("Change difficulty on client from %s by %s to %s."\
			% [old_difficulty_level, answer_score, PlayerData.difficulty_level])
	
	return {
		"round_points": _round_data.round_points,
		"correct_answers_count": _round_data.correct_answers_count,
		"total_questions_count": _round_data.question_stats.size(),
		"show_difficulty": old_difficulty_rounded != new_difficulty_rounded
	}


func _setup_postgame_info(round_points: int, questions_answered: int,
			total_questions: int, show_difficulty: bool):
	var success_percentage = floor(float(questions_answered)
			/ float(total_questions) * 100)
	
	$Panel/GameInfo/RoundPoints.text = "%s Punkte erreicht" % round_points
	$Panel/GameInfo/Answers.text = "%s von %s Fragen richtig (%s %%)"\
			% [questions_answered, total_questions, success_percentage]
	$Panel/GameInfo/EndPoints.text = "Neuer Punktestand %s" % \
			PlayerData.jannah_points
	$Panel/GameInfo/NewDifficulty/DifficultyProgress.set_difficulty(
			PlayerData.difficulty_level)
	_show_difficulty_panel = show_difficulty


func _on_Analysis_button_up():
	ViewManager.show_dialog("answers_analysis", {"round_data": _round_data},
			ViewManager.Direction.RIGHT)


func _on_Continue_button_up():
	ViewManager.move_to_view(self, "questions", ViewManager.Direction.LEFT)


func _on_MainMenu_button_up():
	ViewManager.move_to_view(self, "main_menu", ViewManager.Direction.LEFT)
