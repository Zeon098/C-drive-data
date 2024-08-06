extends Control


func _ready():
	pass


func _on_Continue_button_up():
	ViewManager.move_to_view(self, "authentication", ViewManager.Direction.RIGHT)


func _on_Skip_button_up():
	ViewManager.move_to_view(self, "anonymous_registration",
			ViewManager.Direction.RIGHT)
