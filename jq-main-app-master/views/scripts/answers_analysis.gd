extends Control


onready var label : RichTextLabel = \
		$AspectRatioContainer/Panel/ScrollContainer/Label



func will_become_visible():
	# Reset scroll view position to top.
	$AspectRatioContainer/Panel/ScrollContainer.scroll_vertical = 0


func receive_params(params):
	_setup_analysis_text(params.round_data.given_answers_data)


func _setup_analysis_text(given_answers_data : Array):
	var answers_analysis_text = ""
	
	for answer_ind in range(0, given_answers_data.size()):
		var answer_data = given_answers_data[answer_ind]
		var question_text = answer_data.question_text
		var correct_answer_text = answer_data.correct_answer_text
		var given_answer_text = answer_data.given_answer_text
		
		var rich_given_answer_text = ""
		if answer_data.is_answer_correct:
			rich_given_answer_text = "[color=green][i]%s[/i][/color]" \
					% correct_answer_text
		else:
			rich_given_answer_text = "[color=red][i]%s[/i][/color]" \
					% given_answer_text
		
		answers_analysis_text += "%s.\n[i]%s[/i]" % [answer_ind+1, question_text]
		answers_analysis_text += "\nRichtige Antwort:\n[i]%s[/i]" \
				% correct_answer_text
		answers_analysis_text += "\nDeine Antwort:\n%s" % rich_given_answer_text
		
		var is_not_last_answer = answer_ind < given_answers_data.size() - 1
		if is_not_last_answer:
			answers_analysis_text += "\n\n"
	
	label.bbcode_text = answers_analysis_text


func _on_Back_button_up():
	ViewManager.hide_dialog(self, ViewManager.Direction.LEFT)
