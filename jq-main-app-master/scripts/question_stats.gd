extends Node


const stats_file_path = "user://question_stats"

var stats_file : ConfigFile

var _answer_counts_cache: Dictionary = {}


func _ready():
	var stats_file_to_check = File.new()
	if not stats_file_to_check.file_exists(stats_file_path):
		stats_file_to_check.open(stats_file_path, File.WRITE)
		stats_file_to_check.close()
	
	stats_file = ConfigFile.new()
	var error = stats_file.load(stats_file_path)
	
	if error:
		Logger.error("Unable to load stat file: %s" % error)


func get_version_number() -> int:
	var version = 0
	if stats_file.has_section_key("general", "question_version"):
		version = stats_file.get_value("general", "question_version")
	
	return version


func set_version_number(version_number: int):
	stats_file.set_value("general", "question_version", version_number)
	var error = stats_file.save(stats_file_path)
	
	if error:
		Logger.error("Unable to save question stats to file: %s" % error)


func load_answer_counts_from_file():
	if not stats_file.has_section("question_answered_counts"):
		return
	
	for question_id in stats_file.get_section_keys("question_answered_counts"):
		_answer_counts_cache[question_id] = stats_file.get_value(
				"question_answered_counts", question_id)


func get_amount_answered(question_id: String):
	var amount = 0
	if _answer_counts_cache.has(question_id):
		amount = _answer_counts_cache[question_id]
	
	return amount


func set_amount_answered(question_id: String, amount: int):
	_answer_counts_cache[question_id] = amount
	stats_file.set_value("question_answered_counts", question_id, amount)
