extends Control


func _ready():
	pass


func _request_auth_code(email_address: String):
	ViewManager.block_screen("Anmeldung")
	
	var request = ClientAPI.get_auth_code(email_address)
	var result = yield(request, "request_completed")

	Logger.debug("Returned from request: %s" % result)
	
	if result.code == 200:
		PlayerData.email_address = email_address
		yield(ViewManager.unblock_screen(), "completed")
		ViewManager.move_to_view(self, "auth_code", ViewManager.Direction.RIGHT)
		$AspectRatioContainer/Panel/VBoxContainer/VBoxContainer/\
				LineEdit.release_focus()
	else:
		ViewManager.block_screen("Das hat leider nicht geklappt.", 2)


func _is_valid_email_address(email: String) -> bool:
	var regex = RegEx.new()
	regex.compile("(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
	
	return regex.search(email)


func _on_Send_button_up():
	var email_address = \
			$AspectRatioContainer/Panel/VBoxContainer/VBoxContainer/LineEdit.text
	email_address = email_address.strip_edges()
	
	if not _is_valid_email_address(email_address):
		ViewManager.block_screen("Bitte eine gültige Email-Addresse angeben.", 2)
		return
	
	_request_auth_code(email_address)


func _on_Back_button_up():
	ViewManager.move_to_view(self, "onboarding2", ViewManager.Direction.LEFT)
	$AspectRatioContainer/Panel/VBoxContainer/VBoxContainer/LineEdit\
			.release_focus()
