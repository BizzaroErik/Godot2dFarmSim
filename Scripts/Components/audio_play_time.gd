class_name AudioPlayTimer
extends Timer

@export var audio_stream_player: AudioStreamPlayer2D


func _on_timeout() -> void:
	audio_stream_player.play()

func set_audio_stream_player(audio_stream: AudioStreamPlayer2D) -> void:
	audio_stream_player = audio_stream
