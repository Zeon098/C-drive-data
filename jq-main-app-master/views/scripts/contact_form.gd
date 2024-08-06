extends Control


func _ready():
	pass


func _on_Back_button_up():
	ViewManager.move_to_view(self, "main_menu", ViewManager.Direction.LEFT)
	$Panel/TextEdit.release_focus()


func _on_Send_button_up():
	var message = $Panel/TextEdit.text
	if message.empty(): return
	
	ViewManager.block_screen("Nachricht wird versendet.")
	
	var request = ClientAPI.send_contact_message(message)
	var result = yield(request, "request_completed")
	
	if result.code != 200:
		ViewManager.block_screen("Nachricht konnte nicht versendet werden.", 2)
	else:
		$Panel/TextEdit.text = ""
		ViewManager.unblock_screen()
		ViewManager.move_to_view(self, "main_menu", ViewManager.Direction.LEFT)
