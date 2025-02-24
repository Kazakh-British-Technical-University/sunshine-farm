extends AudioStreamPlayer
class_name SFX


func _enter_tree():
	Globals.sfx = self
	

func play_effect(sound_effect):
	stream = sound_effect
	play()
