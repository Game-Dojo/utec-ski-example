extends Node

var game_score := 0
var multiplier := 1

#region Score Management

func set_score( score : int ) -> void:
	game_score = score * multiplier

func get_score() -> int:
	return game_score

#endregion
