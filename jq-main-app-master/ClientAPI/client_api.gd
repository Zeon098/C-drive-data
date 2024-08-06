extends Node


var _auth_token : String


func get_auth_code( email_address ):
	return _execute_request("/player/auth/code", HTTPClient.METHOD_POST,
			{"email": email_address})
	

func authenticate(email_address: String, auth_code: String):
	var params = {
		"email": email_address,
		"code": auth_code,
	}
	
	return _execute_request("/player/auth/login", HTTPClient.METHOD_POST, params)


func authenticate_anonymous():
	return _execute_request("/player/auth/login_anonymous",
			HTTPClient.METHOD_POST)


func load_player_data():
	return _execute_request("/player/data", HTTPClient.METHOD_GET)


func load_game_data():
	return _execute_request("/player/configuration", HTTPClient.METHOD_GET)
	

func set_player_name(player_name):
	return _execute_request("/player/data/name", HTTPClient.METHOD_PUT,
			{"name": player_name})


func set_player_difficulty(difficulty: float):
	return _execute_request("/player/data/difficulty", HTTPClient.METHOD_PUT,
			{"difficulty": difficulty})


func send_contact_message(message: String):
	return _execute_request("/contact/general", HTTPClient.METHOD_POST,
			{"message": message})


func get_highscores():
	return _execute_request("/player/highscores", HTTPClient.METHOD_GET)
	
	
func get_questions(local_version: int):
	return _execute_request("/player/question/published", HTTPClient.METHOD_GET,
			{}, {"If-None-Match": local_version})


func get_difficulties():
	return _execute_request("/player/question/difficulties",
			HTTPClient.METHOD_GET)


func report_question(question_id, reason, description):
	var params = {
		"questionId": question_id,
		"reason": reason,
		"description": description,
	}
	
	return _execute_request("/contact/question", HTTPClient.METHOD_POST,
			params)


func submit_question_stats(question_stats):
	return _execute_request("/player/round/finish", HTTPClient.METHOD_POST,
			question_stats)


func _execute_request(name: String, method: int, body_params = null,
		header_params: Dictionary = {}):
	var request = ClientApiRequest.new()
	add_child(request)

	var body_json = "{}"
	if body_params:
		body_json = JSON.print(body_params)
	
	request.execute_request(
		_auth_token,
		name,
		method,
		body_json,
		header_params
	)
	
	return request
