extends Control

onready var _line_edit = $AspectRatioContainer/Panel/VBoxContainer/\
		VBoxContainer/LineEdit

func _ready():
	pass


func _on_Send_button_up():
	var name_normalized = _normalize_name(_line_edit.text)
	Logger.debug("Normalized name : '%s'" % name_normalized)
	
	_line_edit.text = name_normalized
	
	if name_normalized.length() < 3:
		ViewManager.block_screen("Name muss mindestens 3 Zeichen lang sein", 2)
		return
	elif name_normalized.length() > 20:
		ViewManager.block_screen("Name darf höchstens 20 Zeichen lang sein", 2)
		return
	
	ViewManager.block_screen("Sende Namen an Server.")
	
	var request = ClientAPI.set_player_name(name_normalized)
	var result = yield(request, "request_completed")
	
	if result.code == 200:
		_line_edit.text = ""
		PlayerData.player_name = name_normalized
		yield(ViewManager.unblock_screen(), "completed")
		ViewManager.move_to_view(self, "game_data_loader",
				ViewManager.Direction.RIGHT)
	elif result.code == 422:
		ViewManager.block_screen("Der Name ist schon vergeben. Bitte wähle " +\
				"einen anderen aus.", 2)
	else:
		ViewManager.block_screen("Es gab einen Fehler", 2)

func _on_Cancel_button_up():
	_line_edit.text = ""
	ViewManager.move_to_view(self, "onboarding2", ViewManager.Direction.LEFT)

func _normalize_name(player_name) -> String:
	var regex = RegEx.new()
	regex.compile(" {2,}")
	var replaced = regex.sub(player_name, " ", true)
	return replaced.strip_edges()
