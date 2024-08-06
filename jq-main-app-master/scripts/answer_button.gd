extends TextureButton


class_name AnswerButton


export(Texture) var background_neutral
export(Texture) var background_correct
export(Texture) var background_wrong


func _ready():
	pass


func trigger_correct_state():
	self.texture_normal = background_correct
	
	yield(get_tree().create_timer(2), "timeout")
	
	self.texture_normal = background_neutral


func trigger_wrong_state():
	self.texture_normal = background_wrong
	
	yield(get_tree().create_timer(1), "timeout")
	
	self.texture_normal = background_neutral


func trigger_particles():
	$CPUParticles2D.restart()
