extends Control


var _question_id: String


func _ready():
	pass


func receive_params(parameters: Dictionary):
	_question_id = parameters["question_id"]


func _show_details_dialog(feedback_reason: String):
	var params = {
		"feedback_reason": feedback_reason,
		"question_id": _question_id,
	}
	
	ViewManager.show_dialog("feedback_detail_dialog", params,
			ViewManager.Direction.RIGHT)
	ViewManager.hide_dialog(self, ViewManager.Direction.RIGHT)


func _on_NotUnderstandable_button_up():
	_show_details_dialog("Frage nicht verständlich")


func _on_WrongFormatting_button_up():
	_show_details_dialog("Text ist abgeschnitten")


func _on_WrongContent_button_up():
	_show_details_dialog("Inhaltlicher Fehler")


func _on_WrongLanguage_button_up():
	_show_details_dialog("Sprachlicher Fehler")


func _on_Abort_button_up():
	ViewManager.hide_dialog(self)
