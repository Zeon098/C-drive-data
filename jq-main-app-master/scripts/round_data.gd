extends Reference

class_name RoundData


var correct_answers_count = 0
var score_answers_count = 0

var question_stats = []
var round_points = 0

var given_answers_data = []


func _ready():
	pass


func on_answer_given(answer_data : Dictionary):
	var question_stat = {
		"questionId": answer_data.question_id,
		"answerNum": answer_data.answer_ind,
	}
	
	question_stats.append(question_stat)
	given_answers_data.append(answer_data)
	
	if answer_data.is_answer_correct:
		round_points += _difficulty_to_jp(answer_data.difficulty)
		correct_answers_count += 1
		if answer_data.difficulty > PlayerData.difficulty_level - 1.5:
			score_answers_count += 1
	else:
		if answer_data.difficulty < PlayerData.difficulty_level + 1.5:
			score_answers_count -= 1


func _on_round_ended():
	var answer_score = score_answers_count * 0.2
	var slowdown = GameData.difficulty_progression_slowdown
	if slowdown > 0:
		answer_score /= slowdown
		print_debug("Slowed down difficulty progression by %s" % slowdown)
	
	var old_difficulty_level = PlayerData.difficulty_level
	var old_difficulty_rounded = ceil(PlayerData.difficulty_level)
	PlayerData.update_player_stats(round_points, answer_score)
	var new_difficulty_rounded = ceil(PlayerData.difficulty_level)
	
	print_debug("Change difficulty on client from %s by %s to %s."\
			% [old_difficulty_level, answer_score, PlayerData.difficulty_level])


func _difficulty_to_jp(difficulty: float) -> int:
	return int(ceil(difficulty)) + 2
