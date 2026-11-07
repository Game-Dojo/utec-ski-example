extends Area2D

signal jumped

func _on_body_entered(_body: Node2D) -> void:
	jumped.emit()
