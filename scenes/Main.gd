extends Node

var score = 0

func _ready():
	var coins = get_tree().get_nodes_in_group("coins")
	$Score.text = str(score)
	
	for coin in coins:
		coin.connect("coin_grabbed", self, "_on_coin_grabbed")

func _on_coin_grabbed():
	score += 10
	$Score.text = str(score)
