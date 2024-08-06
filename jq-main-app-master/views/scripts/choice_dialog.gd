extends Control


signal choice_selected


func _ready():
	pass


func set_choice_text(text: String):
	$Panel/ChoiceText.text = text


func _on_Yes_button_up():
	yield(ViewManager.hide_dialog(self), "completed")
	emit_signal("choice_selected", "yes")


func _on_No_button_up():
	yield(ViewManager.hide_dialog(self), "completed")
	emit_signal("choice_selected", "no")
