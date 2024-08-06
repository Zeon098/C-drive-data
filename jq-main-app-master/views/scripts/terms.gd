extends Control


func _ready():
	# Create an HTTP request node and connect its completion signal.
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")

	var error = http_request.request("http://jannahquiz.com/AGB.txt")
	if error != OK:
		push_error("An error occurred in the HTTP request.")


func _http_request_completed(result, response_code, headers, body):
	var label = $AspectRatioContainer/Panel/ScrollContainer/Label
	label.text = body.get_string_from_utf8()


func _on_Back_button_up():
	ViewManager.move_to_view(self, "options", ViewManager.Direction.LEFT)
