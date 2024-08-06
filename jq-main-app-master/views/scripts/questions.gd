extends Control


var _question_ind = 0
var _questions : Array
var _question_id: String
var _correct_answer_label_ind: int
var _difficulty: float

var _answer_button_map := []

var _round_data : RoundData


func _ready():
	for answer_ind in range(0, 4):
		var answer_button = get_node("Panel/VBoxContainer/AnswerButton%s"
				% (answer_ind))
		answer_button.connect("button_up", self, "_on_answer_button_up",
				[answer_ind, answer_button])
	
	_answer_button_map.resize(4)

func will_become_visible():
	_question_ind = 0
	$Panel/QuestionProgress.value = 0
	
	_round_data = RoundData.new()
	_questions = QuestionLoader.get_questions(7, PlayerData.difficulty_level)
	
	for question in _questions:
		Logger.debug("Question %s, difficulty: %s, answers count: %s" %
				[question.content, question.difficulty, question.answers_count])
	
	_show_next_question()


func _show_next_question():
	var question = _questions[_question_ind]
	
	_question_id = question._id
	_difficulty = question.difficulty
	
	$Panel/DifficultyProgress.set_difficulty(question.difficulty)
	
	$Panel/QuestionStats.text = "%s Jannah Punkte" % \
			(ceil(question.difficulty) + 2)
	
	$Panel/VBoxContainer/MarginContainer/QuestionText.text = question.content
	
	# Setup answers in random order.
	var answer_label_indices_randomized = range(0,4)
	answer_label_indices_randomized.shuffle()
	
	for answer_ind in range(0, 4):
		var answer_label_ind = answer_label_indices_randomized[answer_ind]
		
		var answer = question.answers[answer_ind]
		var answer_text = answer.content
		var answer_label = get_node("Panel/VBoxContainer/AnswerButton%s/Label"
				% answer_label_ind)
		answer_label.text = answer_text
		
		if answer.has("right") and answer.right == true:
			_correct_answer_label_ind = answer_label_ind
		
		# Because of random order we need to keep track of the actual answer
		# index.
		_answer_button_map[answer_label_ind] = answer_ind


func _on_answer_button_up(answer_label_ind: int, button: AnswerButton):
	$Panel/MouseBlocker.visible = true
	$Panel/QuestionProgress.value += 1

	var answer_ind = _answer_button_map[answer_label_ind]

	var is_answer_correct = answer_label_ind == _correct_answer_label_ind
	var correct_button = get_node("Panel/VBoxContainer/AnswerButton%s"
			% _correct_answer_label_ind)
	if is_answer_correct:
		AudioEngine.play_sound("Sfx", "answer_correct")
		button.trigger_particles()
		yield(button.trigger_correct_state(), "completed")
	else:
		AudioEngine.play_sound("Sfx", "answer_false")
		yield(button.trigger_wrong_state(), "completed")
		yield(correct_button.trigger_correct_state(), "completed")
	
	var current_question = _questions[_question_ind]
	var answer_data = {
		"is_answer_correct" : is_answer_correct,
		"question_id" : _question_id,
		"answer_ind" : answer_ind,
		"difficulty" : _difficulty,
		"question_text" : current_question.content,
		"correct_answer_text" : correct_button.get_node("Label").text,
		"given_answer_text" : button.get_node("Label").text
	}
	_round_data.on_answer_given(answer_data)
	
	if _question_ind == _questions.size() - 1:
		# Proceed to post game.
		ViewManager.move_to_view(self, "post_game", ViewManager.Direction.RIGHT,
				{"round_data": _round_data})
	else:
		# Proceed to next question.
		_question_ind += 1
		_show_next_question()
	
	$Panel/MouseBlocker.visible = false


func _on_Feedback_button_up():
	ViewManager.show_dialog("feedback_dialog", {"question_id": _question_id})


func _on_Cancel_button_up():
	ViewManager.show_choice_dialog("Runde abbrechen?")
	var choice = yield(ViewManager, "choice_completed")
	
	if choice == "yes":
		ViewManager.move_to_view(self, "main_menu", ViewManager.Direction.LEFT)
