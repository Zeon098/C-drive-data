extends Node2D


func _ready():
	pass


func play_sound(channel: String, name: String):
	if not has_node("%sAudioStreamPlayer" % channel):
		Logger.warn("No audio stream player found with name %s." % channel)
	
	var audio_stream_player : AudioStreamPlayer = \
			get_node("%sAudioStreamPlayer" % channel)
	
	var stream_path = "res://audio/%s/%s.wav" % [channel.to_lower(), name]
	if not ResourceLoader.exists(stream_path):
		stream_path = "res://audio/%s/%s.mp3" % [channel.to_lower(), name]
		if not ResourceLoader.exists(stream_path):
			Logger.warn("Audio file not found: %s" % name)
			return
	
	var stream = load(stream_path)
	audio_stream_player.stream = stream
	audio_stream_player.play()


func on_button_pressed():
	play_sound("Sfx", "button_click")


func setup_button_sound(view):
	if view.name == "Questions":
		return
	
	_connect_view_buttons(view)


func _connect_view_buttons(root):
	for child in root.get_children():
		if child is BaseButton:
			child.connect("button_down", self, "on_button_pressed")
		_connect_view_buttons(child)
