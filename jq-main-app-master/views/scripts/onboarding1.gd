extends Node


func _process(delta):
	if PlayerData.auth_token and not PlayerData.auth_token.empty():
		PlayerData.load_playerdata()
		ViewManager.move_to_view_no_transition(self, "game_data_loader")


func _on_ContinueButton_button_up():
	PlayerData.load_playerdata()
	ViewManager.move_to_view(self, "onboarding2", ViewManager.Direction.RIGHT)
