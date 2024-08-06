extends Control


func _ready():
	pass


func _send_auth_code():
	var auth_code = get_node("AspectRatioContainer/Panel/VBoxContainer/" +
			"VBoxContainer/LineEdit").text
	if not auth_code:
		ViewManager.block_screen("Bitte den Code eingeben.", 2)
		return

	ViewManager.block_screen("Anmeldung")
	
	var request = ClientAPI.authenticate(PlayerData.email_address, auth_code)
	var response = yield(request, "request_completed")
	
	if response.code == 200:
		var body = response["body"] as Dictionary
		var token = body["token"]
		Logger.debug("Token recieved: %s" % token)
		PlayerData.save_auth_token(token)
		ClientAPI._auth_token = token
	else:
		ViewManager.block_screen("Das hat leider nicht geklappt.", 2)
		return
	
	yield(ViewManager.unblock_screen(), "completed")
	ViewManager.move_to_view(self, "game_data_loader",
			ViewManager.Direction.RIGHT)
	$AspectRatioContainer/Panel/VBoxContainer/VBoxContainer/LineEdit\
			.release_focus()


func _on_Back_button_up():
	ViewManager.move_to_view(self, "authentication", ViewManager.Direction.LEFT)
	$AspectRatioContainer/Panel/VBoxContainer/VBoxContainer/LineEdit\
			.release_focus()


func _on_Send_button_up():
	_send_auth_code()
