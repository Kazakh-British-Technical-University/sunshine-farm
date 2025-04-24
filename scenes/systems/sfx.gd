extends AudioStreamPlayer

enum {
	BUY,
	SELL,
	INTERACT
}

var AudioLibrary: Dictionary = {
	BUY: load("res://assets/audio/handleCoins.ogg"),
	SELL: load("res://assets/audio/clothBelt2.ogg"),
	INTERACT: load("res://assets/audio/handleSmallLeather2.ogg")
}

func play_effect(clip):
	stream = AudioLibrary[clip]
	play()
