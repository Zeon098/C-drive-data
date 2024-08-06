extends Control


var _should_load := true

func _ready():
	_should_load = true

func _process(delta):
	if _should_load:
		_should_load = false
		_load_player_data()

func _load_player_data():
	ViewManager.block_screen("Lade Spielerdaten")
	
	var player_data_request = ClientAPI.load_player_data()
	var player_data_response = yield(player_data_request, "request_completed")
	
	if player_data_response.code != 200:
		_should_load = true
		return
	
	PlayerData.difficulty_level = player_data_response.body.difficulty as float
	PlayerData.jannah_points = player_data_response.body.points_total as int
	
	var has_name = player_data_response.body.has("name")
	var player_name = null
	
	# Name already chosen
	if has_name:
		PlayerData.player_name = player_data_response.body.name
	# Has registered but not chosen name yet
	elif not PlayerData.is_player_anonymous:
		yield(ViewManager.unblock_screen(), "completed")
		ViewManager.move_to_view(self, "chose_name", ViewManager.Direction.RIGHT)
		return
	# Anonymous player
	else:
		PlayerData.player_name = "Anonymer Spieler"
	
	Logger.debug("Received %s JP and difficulty %s" % 
			[PlayerData.jannah_points, PlayerData.difficulty_level])
	
	ViewManager.block_screen("Warte auf Spieldaten")
	var game_data_request = ClientAPI.load_game_data()
	var game_data_response = yield(game_data_request, "request_completed")
	
	if game_data_response.code != 200:
		_should_load = true
		return
	
	GameData.difficulty_progression_slowdown = game_data_response.body\
			["difficultyProgressionSlowdown"]
	GameData.question_selection_range = game_data_response.body\
			["questionSelectionRange"]
	GameData.lowest_valid_client_version = game_data_response.body\
			["lowestValidClientVersion"]
			
	Logger.debug("Received slowdown %s, range %s, version %s" %
			[GameData.difficulty_progression_slowdown,
			GameData.question_selection_range,
			GameData.lowest_valid_client_version])
	
	ViewManager.block_screen("Lade Fragenstatistiken")
	QuestionStats.load_answer_counts_from_file()
	
	yield(ViewManager.unblock_screen(), "completed")
	ViewManager.move_to_view(self, "main_menu", ViewManager.Direction.RIGHT)
