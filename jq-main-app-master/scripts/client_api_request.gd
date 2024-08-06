extends Node


class_name ClientApiRequest


signal request_completed


const _api_version = 1
const _base_url = "https://api.jannahquiz.com/v%s" % _api_version

var _request_name : String


func execute_request(
		auth_token: String,
		name: String,
		method: int,
		body_json: String = "{}",
		header_params: Dictionary = {}
	):
	_request_name = name
	
	# GET request must not have a body in web browser target.
	if method == HTTPClient.METHOD_GET:
		body_json = ""
	
	var url = "%s%s" % [_base_url, name]
	
	var headers = []
	if auth_token:
		headers.append("Authorization: Bearer %s" % auth_token)
	if method == HTTPClient.METHOD_PUT or method == HTTPClient.METHOD_POST:
		headers.append("Content-Type: application/json")
	
	# Append user provided headers.
	for header_key in header_params.keys():
		var header_entry = "%s: %s" % [header_key, header_params[header_key]]
		headers.append(header_entry)
	
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")
	
	var error = http_request.request(url, headers, true, method, body_json)
	if error != OK:
		print_debug("Network error: %s" % error)
	
	return yield()


func _http_request_completed(result, response_code, headers, body):
	Logger.info("Request %s returned code %s." % [_request_name, response_code])
	
	var json = JSON.parse(body.get_string_from_utf8())
	
	var response = {
		"code": response_code,
	}
	
	if response_code == 200:
		response["body"] = json.result
		response["etag"] = _find_etag(headers)
	else:
		response["error_string"] = json.error_string
	
	emit_signal("request_completed", response)
	self.queue_free()


func _find_etag(headers) -> String:
	var etag_value = ""
	
	for header in headers:
		if header.begins_with("ETag"):
			etag_value = header.split(":")[1]
			etag_value = etag_value.strip_edges()
			
			break
	
	return etag_value
