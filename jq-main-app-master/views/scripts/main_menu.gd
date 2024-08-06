extends Control


func will_become_visible():
	var status_text = "%s" % PlayerData.player_name
	if PlayerData.jannah_points > 0:
		status_text += "\n%s Jannah Punkte" % PlayerData.jannah_points
	
	$Panel/PlayerData.text = status_text
	$Panel/TextureProgress.set_difficulty(
			PlayerData.difficulty_level)	


func _ready():
	HighscoreLoader.load_highscores()
	yield(QuestionLoader.load_questions(), "completed")
	QuestionLoader.load_difficulties()


func _on_Options_button_up():
	ViewManager.move_to_view(self, "options", ViewManager.Direction.RIGHT)


func _on_Contact_button_up():
	ViewManager.move_to_view(self, "contact_form", ViewManager.Direction.RIGHT)


func _on_Highscore_button_up():
	if PlayerData.is_player_anonymous:
		ViewManager.block_screen("Bitte E-Mail Adresse verknüpfen", 2)
	else:
		ViewManager.move_to_view(self, "highscore", ViewManager.Direction.RIGHT)


func _on_Play_button_up():
	if QuestionLoader.questions.size() == 0:
		ViewManager.block_screen("Keine Fragen geladen.", 2)
	else:
		ViewManager.move_to_view(self, "questions", ViewManager.Direction.RIGHT)
