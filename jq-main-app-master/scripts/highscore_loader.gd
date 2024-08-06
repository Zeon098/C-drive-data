extends Node


var top_ten_weekly : Array
var top_ten_total : Array
var local_weekly : Array
var local_total : Array


func _ready():
	pass


func load_highscores():
	var request = ClientAPI.get_highscores()
	var response = yield(request, "request_completed")
	
	if response.code == 200:
		var body = response["body"] as Dictionary
		top_ten_weekly = body["weeklyHighScores"]
		top_ten_total = body["totalHighScores"]
		local_weekly = body["weeklyRelativeScores"]
		local_total = body["totalRelativeScores"]
		
		Logger.debug("""Recieved highscores:
				ttw: %s
				ttl: %s
				lw: %s
				lt: %s""" % [top_ten_weekly, top_ten_total, local_weekly, local_total])
	else:
		Logger.debug("Error loading highscores %s" % response.code)
