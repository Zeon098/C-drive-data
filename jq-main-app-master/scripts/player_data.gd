extends Node


const auth_token_file_path = "user://token.dat"

const playerdata_file_path = "user://playerdata"
var playerdata_file : ConfigFile

var email_address: String
var auth_token: String

var player_name: String

var is_player_anonymous = false

var difficulty_level: float
var jannah_points: int


func _ready():
	auth_token = load_auth_token()
	ClientAPI._auth_token = auth_token
	
	var playerdata_file_to_check = File.new()
	if not playerdata_file_to_check.file_exists(playerdata_file_path):
		playerdata_file_to_check.open(playerdata_file_path, File.WRITE)
		playerdata_file_to_check.close()
	
	playerdata_file = ConfigFile.new()
	var error = playerdata_file.load(playerdata_file_path)
	
	if error:
		Logger.error("Unable to load playerdata file: %s" % error)


func save_auth_token(auth_token: String):
	var file = File.new()
	file.open(auth_token_file_path, File.WRITE)
	file.store_string(auth_token)
	file.close()


func load_auth_token() -> String:
	var file = File.new()
	if not file.file_exists(auth_token_file_path):
		return ""
	
	file.open(auth_token_file_path, File.READ)
	var auth_token = file.get_as_text()
	file.close()
	return auth_token


func update_player_stats(jp_delta: int, difficulty_level_delta: float):
	jannah_points += jp_delta
	difficulty_level += difficulty_level_delta
	
	difficulty_level = clamp(difficulty_level, 1, 10)


func save_playerdata():
	playerdata_file.set_value("Account", "IsAnonymous", is_player_anonymous)
	var error = playerdata_file.save(playerdata_file_path)
	
	if error:
		Logger.error("Unable to save playerdata file: %s" % error)


func load_playerdata():
	is_player_anonymous = playerdata_file.get_value("Account", "IsAnonymous",
			false)
