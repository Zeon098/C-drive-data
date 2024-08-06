extends Control


func _ready():
	pass


func did_become_visible():
	ViewManager.block_screen("Anmeldung")
	
	var request = ClientAPI.authenticate_anonymous()
	var response = yield(request, "request_completed")
	
	if response.code == 200:
		var body = response["body"] as Dictionary
		var token = body["token"]
		Logger.debug("Token recieved: %s" % token)
		PlayerData.save_auth_token(token)
		ClientAPI._auth_token = token
		
		PlayerData.is_player_anonymous = true
		PlayerData.save_playerdata()
		
		yield(ViewManager.unblock_screen(), "completed")
		ViewManager.move_to_view(self, "game_data_loader",
				ViewManager.Direction.RIGHT)
	else:
		yield(ViewManager.block_screen("Das hat leider nicht geklappt.", 2),
				"completed")
		ViewManager.move_to_view(self, "onboarding2",
				ViewManager.Direction.LEFT)
