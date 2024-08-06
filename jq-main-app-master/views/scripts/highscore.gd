extends Control


export(Font) var font_regular
export(Font) var font_bold


func _ready():
	pass


func will_become_visible():
	_populate_list()


func _populate_list():
	var highscore_list = _find_selected_list()
	
	for clear_ind in range(1,11):
		var entry_container = get_node(
				"AspectRatioContainer/Panel/Entries/Entry%s" % clear_ind)
		entry_container.get_node("Rank").text = ""
		entry_container.get_node("Name").text = ""
		entry_container.get_node("Score").text = ""
	
	var index = 1
	for entry in highscore_list:
		var entry_container = get_node(
				"AspectRatioContainer/Panel/Entries/Entry%s" % index)
		entry_container.get_node("Rank").text = "%s." % entry.position 
		entry_container.get_node("Name").text = entry.name 
		entry_container.get_node("Score").text = "%s" % _comma_sep(entry.points)
		
		if entry.name == PlayerData.player_name:
			entry_container.get_node("Rank").add_font_override("font", font_bold)
			entry_container.get_node("Name").add_font_override("font", font_bold)
			entry_container.get_node("Score").add_font_override("font", font_bold)
		else:
			entry_container.get_node("Rank").add_font_override("font", font_regular)
			entry_container.get_node("Name").add_font_override("font", font_regular)
			entry_container.get_node("Score").add_font_override("font", font_regular)
		
		index += 1


func _comma_sep(n: int) -> String:
	var result := ""
	var i: int = abs(n)

	while i > 999:
		result = ".%03d%s" % [i % 1000, result]
		i /= 1000

	return "%s%s%s" % ["-" if n < 0 else "", i, result]


func _find_selected_list():
	var location_ind = \
			$AspectRatioContainer/Panel/HBoxContainer/LocationButton.selected
	var time_ind = $AspectRatioContainer/Panel/HBoxContainer/TimeButton.selected
	
	if location_ind == 0 and time_ind == 0:
		return HighscoreLoader.top_ten_total
	elif location_ind == 0 and time_ind == 1:
		return HighscoreLoader.top_ten_weekly
	elif location_ind == 1 and time_ind == 0:
		return HighscoreLoader.local_total
	elif location_ind == 1 and time_ind == 1:
		return HighscoreLoader.local_weekly


func _on_LocationButton_item_selected(index):
	_populate_list()


func _on_TimeButton_item_selected(index):
	_populate_list()


func _on_Back_button_up():
	ViewManager.move_to_view(self, "main_menu", ViewManager.Direction.LEFT)
