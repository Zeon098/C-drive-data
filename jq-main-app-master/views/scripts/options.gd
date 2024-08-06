extends Control


func _ready():
	pass


func _on_Back_button_up():
	ViewManager.move_to_view(self, "main_menu", ViewManager.Direction.LEFT)


func _on_Terms_button_up():
	ViewManager.move_to_view(self, "terms", ViewManager.Direction.RIGHT)


func _on_Schwierigkeit_button_up():
	ViewManager.move_to_view(self, "chose_difficulty",
			ViewManager.Direction.RIGHT)
