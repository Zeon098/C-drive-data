extends Node


const local_question_file_path = "user://questions.json"
const local_difficulties_file_path = "user://difficulties.json"

var questions : Array
var difficulties : Dictionary


func _ready():
	pass


func load_questions():
	var local_version = QuestionStats.get_version_number()
	
	var request = ClientAPI.get_questions(local_version)
	var response = yield(request, "request_completed")
	
	if response.code == 200:
		var remote_questions_version = int(response.etag)
		if remote_questions_version > local_version:
			Logger.info(
				"Received questions with version %s, old version was %s." %
				[remote_questions_version, local_version]
			)
			
			_save_to_file(response.body, local_question_file_path)
		
			QuestionStats.set_version_number(remote_questions_version)
	
	questions = _load_from_file(local_question_file_path)
	
	if questions.empty():
		# There was an error reading the file, override it.
		_save_to_file(response.body, local_question_file_path)
		questions = _load_from_file(local_question_file_path)
	
	for question in questions:
		var answers_count = QuestionStats.get_amount_answered(question._id)
		question["answers_count"] = answers_count


func load_difficulties():
	var request = ClientAPI.get_difficulties()
	var response = yield(request, "request_completed")
	
	if response.code == 200:
		_save_to_file(response.body, local_difficulties_file_path)
	
	var difficulty_list = _load_from_file(local_difficulties_file_path)
	difficulties.clear()
	for difficulty_entry in difficulty_list:
		difficulties[difficulty_entry.id] = difficulty_entry.difficulty
	
	# Update question difficulties.
	for question in questions:
		if difficulties.has(question._id):
			var difficulty = difficulties[question._id]
			question.difficulty = difficulty


func get_questions(amount: int, difficulty: float):
	if amount > questions.size():
		return null
	
	var time_start = OS.get_ticks_msec()
	
	randomize()
	
	difficulty = clamp(difficulty, 1, 10)
	
	var range_delta = float(GameData.question_selection_range) / 2
	var lower_difficulty = difficulty - range_delta
	var upper_difficulty = difficulty + range_delta
	
	var filtered_questions = []
	for question in questions:
		if question.difficulty >= lower_difficulty and \
				question.difficulty <= upper_difficulty:
			filtered_questions.append(question)
	
	Logger.debug("%s questions in range (%s, %s) found."
			% [filtered_questions.size(), lower_difficulty, upper_difficulty])
	filtered_questions.shuffle()
	
	filtered_questions.sort_custom(QuestionSorter, "sort_least_answered")
	var result = filtered_questions.slice(0, amount - 1)
	result.shuffle()
	
	var time_elapsed = OS.get_ticks_msec() - time_start
	Logger.debug("Time for question selection is %s" % time_elapsed)
	
	return result

func _save_to_file(content, file_path):
	var file = File.new()
	file.open(file_path, File.WRITE)
	
	var json = JSON.print(content)
	
	file.store_line(json)
	file.close()


func _load_from_file(file_path):
	var file = File.new()
	Logger.debug("Reading questions from %s" % file_path)
	var error = file.open(file_path, File.READ)
	if error:
		Logger.warn("Opening file %s failed with eyrror code %s." % [file_path, error])
		return []
	
	var json = file.get_line()
	
	var parse_result = JSON.parse(json)
	if parse_result.error:
		Logger.error("Unable to parse from local JSON: %s", parse_result.error)
		return []
	else:
		return parse_result.result

class QuestionSorter:
	static func sort_least_answered(lhs, rhs):
		return lhs.answers_count < rhs.answers_count
