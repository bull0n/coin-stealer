extends Area2D

signal coin_grabbed

func _on_Coin_body_entered(body):
	emit_signal("coin_grabbed")
	queue_free()

