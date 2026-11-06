extends Node

@onready var player: CharacterBody2D = $Player
@onready var jumps: Node2D = $Jumps

func _ready() -> void:
	for area in jumps.get_children():
		area.jumped.connect(on_jump)
	
func on_jump() -> void:
	player.jump()
