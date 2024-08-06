extends Control


var _feedback_reason: String
var _question_id: String


func _ready():
	pass


func receive_params(parameters: Dictionary):
	_feedback_reason = parameters["feedback_reason"]
	_question_id = parameters["question_id"]


func _on_Send_button_up():
	$Panel/TextEdit.release_focus()
	
	ViewManager.block_screen("Danke für dein Feedback!", 2)
	
	var questions_version = QuestionStats.get_version_number()
	var message = "%s\n\nFragenversion: %s" % [$Panel/TextEdit.text,
			questions_version]
	
	ClientAPI.report_question(_question_id, _feedback_reason, message)
	
	$Panel/TextEdit.text = ""
	ViewManager.hide_dialog(self)


func _on_Back_button_up():
	$Panel/TextEdit.release_focus()
	
	ViewManager.show_dialog(
		"feedback_dialog",
		{},
		ViewManager.Direction.LEFT)
	
	$Panel/TextEdit.text = ""
	ViewManager.hide_dialog(self, ViewManager.Direction.LEFT)
