extends Control


func _ready():
	$AspectRatioContainer/Panel/TextureProgress.set_difficulty(
			PlayerData.difficulty_level)


func _on_Send_button_up():
	var difficulty = $AspectRatioContainer/Panel/TextureProgress.difficulty
	
	ViewManager.block_screen("Sende Schwierigkeitsgrad an Server.")
	
	var request = ClientAPI.set_player_difficulty(difficulty)
	var result = yield(request, "request_completed")
	
	if result.code == 200:
		yield(ViewManager.unblock_screen(), "completed")
		PlayerData.difficulty_level = difficulty
		ViewManager.move_to_view(self, "options", ViewManager.Direction.LEFT)
	else:
		ViewManager.block_screen("Server konnte nicht erreicht werden.", 2)

func _on_Back_button_up():
	ViewManager.move_to_view(self, "options", ViewManager.Direction.LEFT)
